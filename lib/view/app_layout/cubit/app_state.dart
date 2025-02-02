part of 'app_cubit.dart';

@immutable
abstract class AppStates {}

class AppInitial extends AppStates {}

class AppChangeBottomNavState extends AppStates {}

class LogoutState extends AppStates {}

class ChangeBottomNavBar extends AppStates {}

class GetUserDataLoadingState extends AppStates {}

class GetUserDataSuccessState extends AppStates {}

class GetUserDataFailureState extends AppStates {
  final String message;

  GetUserDataFailureState({required this.message});
}


class RefreshSessionLoadingState extends AppStates {}

class RefreshSessionSuccessState extends AppStates {
  final RefreshAuthSessionModel data;

  RefreshSessionSuccessState({required this.data});
}

class RefreshSessionFailureState extends AppStates {
  final String message;

  RefreshSessionFailureState({required this.message});
}
