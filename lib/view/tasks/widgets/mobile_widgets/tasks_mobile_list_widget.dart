import 'package:flutter/material.dart';
import 'package:task_manager_app/view/tasks/widgets/mobile_widgets/task_mobile_item_widget.dart';

class TasksMobileListWidget extends StatelessWidget {
  const TasksMobileListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
                (context, index) {
              return const TaskMobileItemWidget();
            },
            childCount: 3
        ));
  }
}
