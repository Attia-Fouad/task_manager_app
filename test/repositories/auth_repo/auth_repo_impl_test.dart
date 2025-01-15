import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager_app/core/networks/failures.dart';
import 'package:task_manager_app/core/networks/remote/api_constants.dart';
import 'package:task_manager_app/core/networks/remote/dio_helper.dart';
import 'package:task_manager_app/models/refresh_auth_session_model.dart';
import 'package:task_manager_app/models/user_data_model.dart';
import 'package:task_manager_app/repositories/auth_repo/auth_repo_impl.dart';
import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([DioHelper])
void main() {
  late AuthRepoImpl authRepoImpl;
  late MockDioHelper mockDioHelper;

  setUp(() {
    mockDioHelper = MockDioHelper();
    authRepoImpl = AuthRepoImpl(dioHelper: mockDioHelper);
  });

  group('AuthRepoImpl Tests', () {
    test('login should return UserDataModel on success', () async {
      // Arrange
      const mockResponse = {
        'id': 1,
        'username': 'testuser',
        'email': 'testuser@example.com',
        'firstName': 'Test',
        'lastName': 'User',
        'gender': 'Male',
        'image': 'image_url',
        'accessToken': 'access_token_value',
        'refreshToken': 'refresh_token_value',
      };

      when(mockDioHelper.postData(
        url: ApiConstants.login,
        data: {
          "username": "testuser",
          "password": "password123",
        },
      )).thenAnswer(
        (_) async => Response(
          data: mockResponse,
          statusCode: 200,
          requestOptions: RequestOptions(
            path: ApiConstants.login,
          ),
        ),
      );

      // Act
      final result = await authRepoImpl.login(
        username: 'testuser',
        password: 'password123',
      );

      // Assert
      expect(result, isA<Right>());
      final user = result.getOrElse(() => UserDataModel.fromJson(mockResponse));
      expect(user.username, 'testuser');
    });

    test('login should return ServerFailure on DioException', () async {
      // Arrange
      when(mockDioHelper.postData(
        url: ApiConstants.login,
        data: {
          "username": "testuser",
          "password": "password123",
        },
      )).thenThrow(DioException(
          requestOptions: RequestOptions(
        path: ApiConstants.login,
      )));

      // Act
      final result = await authRepoImpl.login(
        username: 'testuser',
        password: 'password123',
      );

      // Assert
      expect(result, isA<Left>());
      final failure = result.fold((l) => l, (r) => null);
      expect(failure, isA<ServerFailure>());
    });

    test('getCurrentUserData should return UserDataModel on success', () async {
      // Arrange
      const mockResponse = {
        'id': 1,
        'username': 'testuser',
        'email': 'testuser@example.com',
        'firstName': 'Test',
        'lastName': 'User',
        'gender': 'Male',
        'image': 'image_url',
        'accessToken': 'access_token_value',
        'refreshToken': 'refresh_token_value',
      };

      when(mockDioHelper.getData(
        url: ApiConstants.currentUserData,
        sendToken: true,
      )).thenAnswer(
        (_) async => Response(
          data: mockResponse,
          statusCode: 200,
          requestOptions: RequestOptions(
            path: ApiConstants.currentUserData,
          ),
        ),
      );

      // Act
      final result = await authRepoImpl.getCurrentUserData();

      // Assert
      expect(result, isA<Right>());
      final user = result.getOrElse(() => UserDataModel.fromJson(mockResponse));
      expect(user.username, 'testuser');
    });

    test('getCurrentUserData should return ServerFailure on DioException',
        () async {
      // Arrange
      when(mockDioHelper.getData(
        url: ApiConstants.currentUserData,
        sendToken: true,
      )).thenThrow(DioException(
          requestOptions: RequestOptions(
        path: ApiConstants.currentUserData,
      )));

      // Act
      final result = await authRepoImpl.getCurrentUserData();

      // Assert
      expect(result, isA<Left>());
      final failure = result.fold((l) => l, (r) => null);
      expect(failure, isA<ServerFailure>());
    });

    test('refreshAuthSession should return RefreshAuthSessionModel on success',
        () async {
      // Arrange
      const mockResponse = {
        'accessToken': 'new_access_token',
        'refreshToken': 'new_refresh_token',
      };

      when(mockDioHelper.postData(url: ApiConstants.refreshAuthSession, data: {
        "refreshToken": 'new_refresh_token',
      })).thenAnswer(
        (_) async => Response(
          data: mockResponse,
          statusCode: 200,
          requestOptions: RequestOptions(
            path: ApiConstants.refreshAuthSession,
          ),
        ),
      );

      // Act
      final result = await authRepoImpl.refreshAuthSession(
          refreshToken: 'new_refresh_token');

      // Assert
      expect(result, isA<Right>());
      final refreshSession = result
          .getOrElse(() => RefreshAuthSessionModel.fromJson(mockResponse));
      expect(refreshSession.accessToken, 'new_access_token');
    });

    test('refreshAuthSession should return ServerFailure on DioException',
        () async {
      // Arrange
      when(mockDioHelper.postData(url: ApiConstants.refreshAuthSession, data: {
        "refreshToken": "refreshTokenValue",
      })).thenThrow(DioException(
          requestOptions: RequestOptions(
        path: ApiConstants.refreshAuthSession,
      )));

      // Act
      final result = await authRepoImpl.refreshAuthSession(
          refreshToken: "refreshTokenValue");

      // Assert
      expect(result, isA<Left>());
      final failure = result.fold((l) => l, (r) => null);
      expect(failure, isA<ServerFailure>());
    });
  });
}
