import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/shared_components.dart';
import 'package:task_manager_app/view/app_layout/cubit/app_cubit.dart';
import 'package:task_manager_app/view/reusable_widgets/adabtive_layout.dart';
import 'package:task_manager_app/view/reusable_widgets/add_floating_action_button_widget.dart';
import 'package:task_manager_app/view/tasks/cubit/tasks_cubit.dart';
import 'package:task_manager_app/view/tasks/widgets/mobile_widgets/tasks_mobile_layout.dart';
import '../../core/services/services_locator.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<TasksCubit>(),
        child: BlocConsumer<AppCubit, AppStates>(
          buildWhen: (previous, current) =>
              current is GetUserDataSuccessState ||
              current is GetUserDataFailureState,
          listener: (context, state) {
            if (state is GetUserDataSuccessState) {
              // get tasks after getting user data
              TasksCubit.get(context)
                  .getRemoteTasks(userId: AppCubit.get(context).userData!.id);
              // start scrolling listener for scrolling pagination
              TasksCubit.get(context).startScrollingListener(
                  userId: AppCubit.get(context).userData!.id);
            }
            if (state is GetUserDataFailureState) {
              // show error message
              showToast(state: ToastStates.ERROR, text: state.message);
            }
          },
          builder: (context, state) {
            return AdaptiveLayout(
                mobileLayout: (context) => const TasksMobileLayout(),
                tabletLayout: (context) => const TasksMobileLayout());
          },
        ),
      ),
      floatingActionButton: AddFloatingActionButtonWidget(
        onPressed: () {},
      ),
    );
  }
}
