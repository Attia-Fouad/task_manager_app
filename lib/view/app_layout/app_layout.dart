import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/app_cubit.dart';

class AppLayoutScreen extends StatefulWidget {
  const AppLayoutScreen({super.key});

  @override
  State<AppLayoutScreen> createState() => _AppLayoutScreenState();
}

class _AppLayoutScreenState extends State<AppLayoutScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) async {
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: SizedBox(child: ElevatedButton(
              onPressed: (){
                cubit.getRemoteUserData();
              },
                child: Text('app layout')),),
          ), /*Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              LazyLoadIndexedStack(
                index: cubit.currentIndex,
                children:
                    cubit.isSeller ? cubit.sellerScreens : cubit.userScreens,
              ),
              CustomNavBarWidget(cubit: cubit),
            ],
          ),*/
        );
      },
    );
  }
}


