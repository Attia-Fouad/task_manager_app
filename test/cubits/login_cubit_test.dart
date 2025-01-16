import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager_app/core/networks/failures.dart';
import 'package:task_manager_app/models/user_data_model.dart';
import 'package:dartz/dartz.dart';
import 'package:task_manager_app/repositories/auth_repo/auth_repo.dart';
import 'package:task_manager_app/view/login/cubit/login_cubit.dart';
import 'app_cubit_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  late MockAuthRepo mockAuthRepo;
  late LoginCubit loginCubit;

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    loginCubit = LoginCubit(authRepo: mockAuthRepo);
  });

  tearDown(() {
    loginCubit.close();
  });

  group('LoginCubit tests', () {
    const username = 'testUser';
    const password = 'testPassword';
    final userData = UserDataModel(
      id: 1,
      username: "testUser",
      email: "test@example.com",
      firstName: "Test",
      lastName: "User",
      gender: "Male",
      image: "testImage.png",
      accessToken: "accessToken123",
      refreshToken: "refreshToken123",
    );
    const failureMessage = "Invalid credentials";

    test('changePasswordVisibility should toggle visibility and emit ChangeVisibilityState', () {
      // Arrange: Initial state is password visible
      expect(loginCubit.isPassword, true);
      expect(loginCubit.suffix, Icons.visibility_outlined);

      // Act: Call changePasswordVisibility to toggle password visibility
      loginCubit.changePasswordVisibility();

      // Assert: Verify that password visibility is toggled and ChangeVisibilityState is emitted
      expect(loginCubit.isPassword, false);
      expect(loginCubit.suffix, Icons.visibility_off_outlined);
      expect(loginCubit.state, isA<ChangeVisibilityState>());
    });

    test('login should emit LoginLoadingState and LoginSuccessState on success', () async {
      // Arrange: Mock the login method to return a success response
      when(mockAuthRepo.login(username: username, password: password))
          .thenAnswer((_) async => Right(userData));

      // Act: Call login method
      loginCubit.login(username: username, password: password);

      // Assert: Verify that the correct states are emitted
      expect(loginCubit.state, isA<LoginLoadingState>());
      await untilCalled(mockAuthRepo.login(username: username, password: password));
      expect(loginCubit.state, isA<LoginSuccessState>());
      expect((loginCubit.state as LoginSuccessState).userData, userData);

      // Verify that the login method was called
      verify(mockAuthRepo.login(username: username, password: password)).called(1);
    });

    test('login should emit LoginLoadingState and LoginFailureState on failure', () async {
      // Arrange: Mock the login method to return a failure
      when(mockAuthRepo.login(username: username, password: password))
          .thenAnswer((_) async => Left(ServerFailure(failureMessage)));

      // Act: Call login method
       loginCubit.login(username: username, password: password);

      // Assert: Verify that the correct states are emitted
      expect(loginCubit.state, isA<LoginLoadingState>());
      await untilCalled(mockAuthRepo.login(username: username, password: password));
      expect(loginCubit.state, isA<LoginFailureState>());
      expect((loginCubit.state as LoginFailureState).message, failureMessage);

      // Verify that the login method was called
      verify(mockAuthRepo.login(username: username, password: password)).called(1);
    });
  });
}
