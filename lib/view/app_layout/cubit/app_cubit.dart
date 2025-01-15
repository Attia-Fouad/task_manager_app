import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/networks/local/cache_helper.dart';
import 'package:task_manager_app/models/refresh_auth_session_model.dart';
import 'package:task_manager_app/models/user_data_model.dart';
import 'package:task_manager_app/repositories/auth_repo/auth_repo.dart';

import '../../../core/constants.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit({required this.authRepo}) : super(AppInitial());

  final AuthRepo authRepo;

  static AppCubit get(context) => BlocProvider.of(context);

  UserDataModel? userData;

  saveUserDataLocal({required UserDataModel userData}) async {
    // save user data locally using shared preferences
    await CacheHelper.saveData(
        key: "userData", value: jsonEncode(userData.toJson()));
  }

  getLocalUserData() async {
    // get user data from shared preferences
    String stringUserData = await CacheHelper.getData(
      key: "userData",
    );
    userData = UserDataModel.fromJson(jsonDecode(stringUserData));
    emit(GetUserDataSuccessState());
  }

  getRemoteUserData() async {
    emit(GetUserDataLoadingState());
    var result = await authRepo.getCurrentUserData();
    result.fold(
      (failure) {
        emit(GetUserDataFailureState(message: failure.message));
        getLocalUserData();
      },
      (data) {
        userData = data;
        emit(GetUserDataSuccessState());
      },
    );
  }

  refreshSession() async {
    emit(RefreshSessionLoadingState());
    var result = await authRepo.refreshAuthSession(refreshToken: await getRefreshToken());
    result.fold(
      (failure) {
        emit(RefreshSessionFailureState(message: failure.message));
      },
      (data) {
        emit(RefreshSessionSuccessState(data: data));
      },
    );
  }
}
