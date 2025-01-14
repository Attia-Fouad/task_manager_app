part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class ChangeVisibilityState extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginSuccessState extends LoginState {
  final UserDataModel userData;

  LoginSuccessState({required this.userData});
}

final class LoginFailureState extends LoginState {
  final String message;

  LoginFailureState({required this.message});
}
