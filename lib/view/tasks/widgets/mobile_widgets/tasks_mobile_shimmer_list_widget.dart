import 'package:flutter/material.dart';
import 'package:task_manager_app/view/tasks/widgets/mobile_widgets/task_mobile_shimmer_item_widget.dart';

class TasksMobileShimmerListWidget extends StatelessWidget {
  const TasksMobileShimmerListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
                (context, index) {
              return const TaskMobileItemShimmer();
            },
            childCount: 5
        ));
  }
}
