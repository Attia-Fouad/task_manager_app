import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/auth_repo/auth_repo.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;

  LoginCubit({required this.authRepo}) : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();

  var signInEmailController = TextEditingController();
  var signInPasswordController = TextEditingController();

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeVisibilityState());
  }

  // login(
  //     {LoginType? loginType,
  //     required String email,
  //     required String password}) async {
  //   emit(LoginLoadingState());
  //   var result = await authRepo.login(
  //     email: email,
  //     password: password,
  //   );
  //   result.fold(
  //     (failure) {
  //       emit(LoginFailureState(message: failure.message));
  //     },
  //     (data) {
  //       emit(LoginSuccessState(
  //         data: data,
  //           loginType: loginType,user: user
  //       ));
  //     },
  //   );
  // }


}
