import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:task_manager_app/view/tasks/widgets/mobile_widgets/tasks_mobile_list_widget.dart';
import 'package:task_manager_app/view/tasks/widgets/mobile_widgets/tasks_mobile_shimmer_list_widget.dart';
import '../../../../core/constants.dart';
import '../../../../core/styles/app_colors.dart';
import '../../cubit/tasks_cubit.dart';
import '../no_tasks_widget.dart';
import '../user_data_section.dart';

class TasksMobileLayout extends StatelessWidget {
  const TasksMobileLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = TasksCubit.get(context);
    return BlocConsumer<TasksCubit, TasksState>(
      listener: (context, state) {},
      builder: (context, state) {
        return RefreshIndicator(
          color: AppColors.primaryColor,
          backgroundColor: Colors.white,
          onRefresh: () async {
            // cubit.getRemoteTasks(userId: userId);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: appPadding),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              slivers: [
                const SliverGap(80),
                // User Data Section
                const UserDataSection(),
                const SliverGap(20),
                //_________________________________________
                // Tasks Section
                // loading when tasks are null until fetching data
                if (cubit.tasksModel == null)
                  const TasksMobileShimmerListWidget()
                // if there are tasks
                else if (cubit.tasksModel!.todos.isNotEmpty)
                  const TasksMobileListWidget()
                // if there are no tasks
                else
                  const NoTasksWidget(),
                const SliverGap(20),
              ],
            ),
          ),
        );
      },
    );
  }
}
