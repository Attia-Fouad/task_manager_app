import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/core/app_router/routes.dart';
import 'package:task_manager_app/core/constants.dart';
import 'package:task_manager_app/core/shared_components.dart';
import 'package:task_manager_app/view/app_layout/cubit/app_cubit.dart';
import 'package:task_manager_app/view/reusable_widgets/adabtive_layout.dart';
import 'package:task_manager_app/view/reusable_widgets/add_floating_action_button_widget.dart';
import 'package:task_manager_app/view/reusable_widgets/loading_dialog.dart';
import 'package:task_manager_app/view/tasks/cubit/tasks_cubit.dart';
import 'package:task_manager_app/view/tasks/widgets/mobile_widgets/tasks_mobile_layout.dart';
import '../../core/services/services_locator.dart';

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
          var appCubit=AppCubit.get(context);
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
                      .getRemoteTasks(userId: appCubit.userData?.id);
                  // start scrolling listener for scrolling pagination
                  tasksCubit.startScrollingListener(
                      userId: appCubit.userData!.id);
                }
                if (state is GetUserDataFailureState) {
                  if (state.message == "Token Expired!") {
                    // refresh session if token expired
                    appCubit.refreshSession();
                  } else {
                    // show error message
                    showToast(state: ToastStates.ERROR, text: state.message);
                  }
                }
          
                if (state is RefreshSessionSuccessState) {
                  await saveToken(token: state.data.accessToken);
                  await saveRefreshToken(token: state.data.refreshToken);
                  appCubit.getRemoteUserData();
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
                      userId: appCubit.userData!.id);
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

