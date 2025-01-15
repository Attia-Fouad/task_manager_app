import 'package:flutter/material.dart';
import 'package:task_manager_app/view/reusable_widgets/base_card_widget.dart';
import '../../../reusable_widgets/default_shimmer.dart';

class TaskMobileItemShimmer extends StatelessWidget {
  const TaskMobileItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: BaseCardWidget(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Circle Icon Placeholder
            DefaultShimmer(
              height: 24,
              width: 24,
              radius: 12, // Circle shape
            ),
            SizedBox(width: 8),
            // Task Description Placeholder
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultShimmer(
                    height: 16,
                    width: double.infinity,
                    radius: 4,
                  ),
                  SizedBox(height: 5),
                  DefaultShimmer(
                    height: 16,
                    width: 200,
                    radius: 4,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            // Trash Icon Placeholder
            DefaultShimmer(
              height: 24,
              width: 24,
              radius: 4,
            ),
          ],
        ),
      ),
    );
  }
}
