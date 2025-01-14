import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_app/models/user_data_model.dart';
import '../../../core/app_router/routes.dart';
import '../../../core/constants.dart';


part 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  UserDataModel? userData;

  int currentIndex = 0;
  List<Widget> userScreens = [
    // const UserHomeScreen(),
    // const UserCalculatorScreen(),
    // const UserProfileScreen(),
  ];

  void changeBottomNavBar(int index, context) {
    if (!isLoggedIn && index == 2) {
      GoRouter.of(context).push(AppRouter.loginScreen);
      return;
    }
    if (kDebugMode) {
      print(index);
    }

    currentIndex = index;

    emit(AppChangeBottomNavState());
  }


}
