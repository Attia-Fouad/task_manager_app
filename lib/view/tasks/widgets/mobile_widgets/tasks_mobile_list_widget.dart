import 'package:flutter/material.dart';
import 'package:task_manager_app/view/tasks/widgets/mobile_widgets/task_mobile_item_widget.dart';

import '../../../../models/task_model.dart';

class TasksMobileListWidget extends StatelessWidget {
  const TasksMobileListWidget({
    super.key,
    required this.tasks,
  });

  final List<TaskModel> tasks;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return TaskMobileItemWidget(
        task: tasks[index],
      );
    }, childCount: tasks.length));
  }
}
