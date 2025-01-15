import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../tasks/tasks_screen.dart';
import 'cubit/app_cubit.dart';

class AppLayoutScreen extends StatefulWidget {
  const AppLayoutScreen({super.key});

  @override
  State<AppLayoutScreen> createState() => _AppLayoutScreenState();
}

class _AppLayoutScreenState extends State<AppLayoutScreen> {
 late AppCubit cubit;
  @override
  initState() {
    cubit=AppCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) async {
      },
      builder: (context, state) {
        return const TasksScreen();
      },
    );
  }
}


