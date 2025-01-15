import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../core/networks/failures.dart';
import '../../core/networks/remote/api_constants.dart';
import '../../core/networks/remote/dio_helper.dart';
import '../../models/refresh_auth_session_model.dart';
import '../../models/user_data_model.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final DioHelper dioHelper;

  AuthRepoImpl({required this.dioHelper});

  @override
  Future<Either<Failure, UserDataModel>> login({
    required String username,
    required String password,
  }) async {
    try {
      var response = await dioHelper.postData(
        url: ApiConstants.login,
        data: {
          "username": username,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        return right(UserDataModel.fromJson(response.data));
      }
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioError(error));
      }
      if (kDebugMode) {
        print("Error when login $error");
      }
    }
    return left(ServerFailure(''));
  }

  @override
  Future<Either<Failure, UserDataModel>> getCurrentUserData() async {
    try {
      var response = await dioHelper.getData(
        url: ApiConstants.currentUserData,
        sendToken: true,
      );
      if (response.statusCode == 200) {
        return right(UserDataModel.fromJson(response.data));
      }
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioError(error));
      }
      if (kDebugMode) {
        print("Error when getCurrentUserData $error");
      }
    }
    return left(ServerFailure(''));
  }

  @override
  Future<Either<Failure, RefreshAuthSessionModel>> refreshAuthSession({required String? refreshToken}) async {
    try {
      var response =
          await dioHelper.postData(url: ApiConstants.refreshAuthSession, data: {
        "refreshToken": refreshToken,
      });
      if (response.statusCode == 200) {
        return right(RefreshAuthSessionModel.fromJson(response.data));
      }
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioError(error));
      }
      if (kDebugMode) {
        print("Error when refreshAuthSession $error");
      }
    }
    return left(ServerFailure(''));
  }
}
