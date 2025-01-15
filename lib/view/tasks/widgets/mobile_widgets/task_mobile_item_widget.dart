import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager_app/models/task_model.dart';
import 'package:task_manager_app/view/reusable_widgets/default_loading_widget.dart';
import 'package:task_manager_app/view/tasks/cubit/tasks_cubit.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../generated/assets.dart';
import '../../../reusable_widgets/base_card_widget.dart';
import '../../../reusable_widgets/read_more_widget.dart';

class TaskMobileItemWidget extends StatefulWidget {
  const TaskMobileItemWidget({
    super.key,
    required this.task,
  });

  final TaskModel task;

  @override
  State<TaskMobileItemWidget> createState() => _TaskMobileItemWidgetState();
}

class _TaskMobileItemWidgetState extends State<TaskMobileItemWidget> {
  bool isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: BaseCardWidget(
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  TasksCubit.get(context).editTask(task: widget.task);
                },
                icon: AnimatedContainer(
                  duration: const Duration(microseconds: 300),
                  child: widget.task.completed
                      ? const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.greenActiveColor,
                        )
                      : const Icon(
                          Icons.circle_outlined,
                          color: AppColors.greyColor,
                        ),
                )),
            Expanded(
                child: ReadMoreWidget(
              text: widget.task.todo,
            )),
            isDeleting
                ? const DefaultLoadingWidget()
                : IconButton(
                    onPressed: () async {
                      setState(() {
                        isDeleting = true;
                      });
                      await TasksCubit.get(context)
                          .deleteTask(task: widget.task);
                      setState(() {
                        isDeleting = false;
                      });
                    },
                    icon: SvgPicture.asset(Assets.svgsTrash)),
          ],
        ),
      ),
    );
  }
}
