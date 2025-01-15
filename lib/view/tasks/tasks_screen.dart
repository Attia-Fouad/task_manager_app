import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        child: AdaptiveLayout(
            mobileLayout: (context) => const TasksMobileLayout(),
            tabletLayout: (context) => const TasksMobileLayout()),
      ),
      floatingActionButton: AddFloatingActionButtonWidget(
        onPressed: () {},
      ),
    );
  }
}
