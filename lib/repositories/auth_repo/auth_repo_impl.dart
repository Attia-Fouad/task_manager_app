import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../core/constants.dart';
import '../../core/networks/failures.dart';
import '../../core/networks/remote/api_constants.dart';
import '../../core/networks/remote/dio_helper.dart';
import '../../models/refresh_auth_session_model.dart';
import '../../models/user_data_model.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<Either<Failure, UserDataModel>> login({
    required String username,
    required String password,
  }) async {
    try {
      var response = await DioHelper.postData(
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
      var response = await DioHelper.getData(
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
  Future<Either<Failure, RefreshAuthSessionModel>> refreshAuthSession() async {
    try {
      var response =
          await DioHelper.postData(url: ApiConstants.refreshAuthSession, data: {
        "refreshToken": await getRefreshToken(),
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
