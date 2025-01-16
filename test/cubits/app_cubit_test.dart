import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager_app/core/networks/failures.dart';
import 'package:task_manager_app/core/networks/local/cache_helper.dart';
import 'package:task_manager_app/models/refresh_auth_session_model.dart';
import 'package:task_manager_app/models/user_data_model.dart';
import 'package:task_manager_app/repositories/auth_repo/auth_repo.dart';
import 'package:task_manager_app/view/app_layout/cubit/app_cubit.dart';

import 'app_cubit_test.mocks.dart';

@GenerateMocks([AuthRepo, CacheHelper])
void main() {
  late MockAuthRepo mockAuthRepo;
  late MockCacheHelper mockCacheHelper;
  late AppCubit appCubit;

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    mockCacheHelper = MockCacheHelper();
    appCubit = AppCubit(authRepo: mockAuthRepo, cacheHelper: mockCacheHelper);
  });

  tearDown(() {
    appCubit.close();
  });

  group('AppCubit Tests', () {
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

    String userDataString = jsonEncode(userData.toJson());

    test('saveUserDataLocal should save user data to CacheHelper', () async {
      when(mockCacheHelper.saveData(key: 'userData', value: userDataString))
          .thenAnswer((_) async => true);

      await appCubit.saveUserDataLocal(userData: userData);

      verify(mockCacheHelper.saveData(key: 'userData', value: userDataString))
          .called(1);
    });

    test(
        'getLocalUserData should emit GetUserDataSuccessState and load user data',
        () async {
      when(mockCacheHelper.getData(key: 'userData'))
          .thenAnswer((_) async => userDataString);

      await appCubit.getLocalUserData();

      expect(appCubit.userData?.id, userData.id);
      expect(appCubit.state, isA<GetUserDataSuccessState>());
      verify(mockCacheHelper.getData(key: "userData")).called(1);
    });

    test(
        'getRemoteUserData should emit GetUserDataFailureState on failure and call getLocalUserData',
        () async {
      when(mockAuthRepo.getCurrentUserData())
          .thenAnswer((_) async => Left(ServerFailure("Error occurred")));
      when(mockCacheHelper.getData(key: "userData"))
          .thenAnswer((_) async => userDataString);

      await appCubit.getRemoteUserData();

      expect(appCubit.state, isA<GetUserDataFailureState>());
      expect((appCubit.state as GetUserDataFailureState).message,
          "Error occurred");
      verify(mockAuthRepo.getCurrentUserData()).called(1);
      verify(mockCacheHelper.getData(key: "userData")).called(1);
    });

    test('refreshSession should emit RefreshSessionSuccessState on success',
        () async {
      // Arrange: Mock the refresh session to return success
      final refreshAuthSessionModel = RefreshAuthSessionModel(
        accessToken: "newAccessToken",
        refreshToken: "newRefreshToken",
      );

      const refreshToken = "refreshToken";
      when(mockAuthRepo.refreshAuthSession(refreshToken: refreshToken))
          .thenAnswer((_) async => Right(refreshAuthSessionModel));

      // Act: Call refreshSession
      appCubit.refreshSession(refreshToken: refreshToken);

      // Assert: Verify the emitted states
      expect(appCubit.state, isA<RefreshSessionLoadingState>());
      await untilCalled(
          mockAuthRepo.refreshAuthSession(refreshToken: refreshToken));
      expect(appCubit.state, isA<RefreshSessionSuccessState>());
      expect((appCubit.state as RefreshSessionSuccessState).data,
          refreshAuthSessionModel);
    });

    test('refreshSession should emit RefreshSessionFailureState on failure',
        () async {
      // Arrange: Mock the refresh session to return failure
      const failureMessage = "Session refresh failed";
      when(mockAuthRepo.refreshAuthSession(refreshToken: "refreshToken"))
          .thenAnswer((_) async => Left(ServerFailure(failureMessage)));

      // Act: Call refreshSession
      appCubit.refreshSession(refreshToken: "refreshToken");

      // Assert: Verify the emitted states
      expect(appCubit.state, isA<RefreshSessionLoadingState>());
      await untilCalled(
          mockAuthRepo.refreshAuthSession(refreshToken: "refreshToken"));
      expect(appCubit.state, isA<RefreshSessionFailureState>());
      expect((appCubit.state as RefreshSessionFailureState).message,
          failureMessage);
    });
  });
}
