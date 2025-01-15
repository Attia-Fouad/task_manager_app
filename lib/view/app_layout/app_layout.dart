import 'package:flutter/material.dart';
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
    if(cubit.userData==null){
      cubit.getRemoteUserData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const TasksScreen();
  }
}


