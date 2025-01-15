import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/core/app_router/routes.dart';
import 'package:task_manager_app/core/constants.dart';
import 'package:task_manager_app/core/shared_components.dart';
import 'package:task_manager_app/view/app_layout/cubit/app_cubit.dart';
import 'package:task_manager_app/view/reusable_widgets/adabtive_layout.dart';
import 'package:task_manager_app/view/reusable_widgets/add_floating_action_button_widget.dart';
import 'package:task_manager_app/view/reusable_widgets/designed_form_field.dart';
import 'package:task_manager_app/view/reusable_widgets/loading_dialog.dart';
import 'package:task_manager_app/view/tasks/cubit/tasks_cubit.dart';
import 'package:task_manager_app/view/tasks/widgets/mobile_widgets/tasks_mobile_layout.dart';
import '../../core/app_strings/app_strings.dart';
import '../../core/services/services_locator.dart';
import '../../core/styles/text_styles.dart';
import '../reusable_widgets/default_button.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TasksCubit>()
        ..getRemoteTasks(userId: AppCubit.get(context).userData?.id),
      child: Builder(
        builder: (context) {
          var tasksCubit=TasksCubit.get(context);
          return Scaffold(
            body: BlocConsumer<AppCubit, AppStates>(
              buildWhen: (previous, current) =>
                  current is GetUserDataSuccessState ||
                  current is GetUserDataFailureState ||
                  current is RefreshSessionFailureState ||
                  current is RefreshSessionSuccessState,
              listener: (context, state) async {
                if (state is GetUserDataSuccessState) {
                  // get tasks after getting user data
                  tasksCubit
                      .getRemoteTasks(userId: AppCubit.get(context).userData?.id);
                  // start scrolling listener for scrolling pagination
                  tasksCubit.startScrollingListener(
                      userId: AppCubit.get(context).userData!.id);
                }
                if (state is GetUserDataFailureState) {
                  if (state.message == "Token Expired!") {
                    // refresh session if token expired
                    AppCubit.get(context).refreshSession();
                  } else {
                    // show error message
                    showToast(state: ToastStates.ERROR, text: state.message);
                  }
                }
          
                if (state is RefreshSessionSuccessState) {
                  await saveToken(token: state.data.accessToken);
                  await saveRefreshToken(token: state.data.refreshToken);
                  AppCubit.get(context).getRemoteUserData();
                }
                if (state is RefreshSessionFailureState) {
                  showToast(state: ToastStates.ERROR, text: state.message);
                  removeToken();
                  removeRefreshToken();
                  GoRouter.of(context).go(AppRouter.loginScreen);
                }
              },
              builder: (context, state) {
                return AdaptiveLayout(
                    mobileLayout: (context) => const TasksMobileLayout(),
                    tabletLayout: (context) => const TasksMobileLayout());
              },
            ),
            floatingActionButton: AddFloatingActionButtonWidget(
              onPressed: () {
                showAddTaskDialog(context, (taskDetails) async {
                  LoadingDialog.show(context);
                  await tasksCubit.addNewTask(
                      taskTitle: taskDetails,
                      userId: AppCubit.get(context).userData!.id);
                  LoadingDialog.hide(context);
                  GoRouter.of(context).pop();
                });
              },
            ),
          );
        }
      ),
    );
  }
}

void showAddTaskDialog(
    BuildContext context, Function(String taskDetails) onAdd) {
  final TextEditingController taskController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Center(
          child: Text(
            AppStrings.addNewTask,
            style: MyTextStyles.textStyle18Bold,
          ),
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DesignedFormField(
                controller: taskController,
                allowMultiLines: true,
                minLines: 3,
                hintText: AppStrings.details,
                validator: (String? val) {
                  if (val == null || val.isEmpty) {
                    return AppStrings.pleaseEnterTaskDetails;
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: DefaultButton(
                  color: const Color(0xffE0E0E0),
                  text: AppStrings.cancel,
                  textStyle: MyTextStyles.textStyle16Bold.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  onTap: () {
                    GoRouter.of(context).pop();
                  },
                ),
              ),
              const Gap(10),
              Expanded(
                child: DefaultButton(
                  text: AppStrings.add,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      onAdd(taskController.text);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
