import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../core/networks/failures.dart';
import '../../core/networks/remote/api_constants.dart';
import '../../core/networks/remote/dio_helper.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  // @override
  // Future<Either<Failure, LoginResponseModel>> login(
  //     {required String email,
  //       required String password,
  //       LoginType? loginType,
  //
  //       required bool isSeller}) async {
  //   try {
  //     var response = await DioHelper.postData(
  //       url: isSeller
  //           ? ApiConstants.sellerLoginEndPoint
  //           : ApiConstants.userLoginEndPoint,
  //       data: {
  //         "email": email,
  //         if (loginType == null) "password": password,
  //         if (loginType != null) "loginType": loginType.name,
  //         "notificationToken": await FirebaseMessaging.instance.getToken(),
  //       },
  //     );
  //     if (response.data['success']) {
  //       return right(LoginResponseModel.fromJson(response.data));
  //     }
  //   } catch (error) {
  //     if (error is DioException) {
  //       return left(ServerFailure.fromDioError(error));
  //     }
  //     if (kDebugMode) {
  //       print("Error when login $error");
  //     }
  //   }
  //   return left(ServerFailure(''));
  // }
}
