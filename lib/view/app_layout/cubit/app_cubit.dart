import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/models/refresh_auth_session_model.dart';
import 'package:task_manager_app/models/user_data_model.dart';
import 'package:task_manager_app/repositories/auth_repo/auth_repo.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit({required this.authRepo}) : super(AppInitial());

  final AuthRepo authRepo;

  static AppCubit get(context) => BlocProvider.of(context);

  UserDataModel? userData;

  getRemoteUserData() async {
    emit(GetUserDataLoadingState());
    var result = await authRepo.getCurrentUserData();
    result.fold(
      (failure) {
        emit(GetUserDataFailureState(message: failure.message));
      },
      (data) {
        userData = data;
        emit(GetUserDataSuccessState());
      },
    );
  }

  refreshSession() async {
    emit(RefreshSessionLoadingState());
    var result = await authRepo.refreshAuthSession();
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
