part of 'app_cubit.dart';

@immutable
abstract class AppStates {}

class AppInitial extends AppStates {}

class AppChangeBottomNavState extends AppStates {}

class LogoutState extends AppStates {}

class ChangeLocaleState extends AppStates {}

class ChangeBottomNavBar extends AppStates {}

class GetUserDataLoadingState extends AppStates {}

class GetUserDataSuccessState extends AppStates {}

class GetUserDataFailureState extends AppStates {
  final String message;

  GetUserDataFailureState({required this.message});
}

class LogoutLoadingState extends AppStates {}
class SetState extends AppStates {}

class LogoutSuccessState extends AppStates {
  final String message;

  LogoutSuccessState({required this.message});
}

class LogoutFailureState extends AppStates {
  final String message;

  LogoutFailureState({required this.message});
}

class DeleteAccountLoadingState extends AppStates {}

class DeleteAccountSuccessState extends AppStates {
  final String message;

  DeleteAccountSuccessState({required this.message});
}

class DeleteAccountFailureState extends AppStates {
  final String message;

  DeleteAccountFailureState({required this.message});
}

class ChangeLanguageLoadingState extends AppStates {}

class ChangeLanguageSuccessState extends AppStates {
  final String message;

  ChangeLanguageSuccessState({required this.message});
}

class ChangeLanguageFailureState extends AppStates {
  final String message;

  ChangeLanguageFailureState({required this.message});
}

class CheckHangoutsAvailabilityLoadingState extends AppStates {}

class CheckHangoutsAvailabilitySuccessState extends AppStates {}

class CheckHangoutsAvailabilityFailureState extends AppStates {
  final String message;
  CheckHangoutsAvailabilityFailureState({required this.message});
}