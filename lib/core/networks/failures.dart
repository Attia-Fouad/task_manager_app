import 'package:dio/dio.dart';
import '../app_strings/app_strings.dart';


abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(AppStrings.connectionTimeOut);
      case DioExceptionType.sendTimeout:
        return ServerFailure(AppStrings.sendTimeOut);
      case DioExceptionType.receiveTimeout:
        return ServerFailure(AppStrings.receiveTimeOut);
      case DioExceptionType.badCertificate:
        return ServerFailure(AppStrings.badCer);
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(e.response!.statusCode!, e.response!);
      case DioExceptionType.cancel:
        return ServerFailure(AppStrings.requestCancelled);
      case DioExceptionType.connectionError:
        return ServerFailure(AppStrings.noInternetConnection);
      case DioExceptionType.unknown:
        return ServerFailure(AppStrings.oppsThereWasAnError);
    }
  }

  factory ServerFailure.fromResponse(int statusCode, Response<dynamic>? response) {
    if (statusCode == 404) {
      return ServerFailure(AppStrings.yourRequestNotFound);
    } else if (statusCode == 500) {
      return ServerFailure(AppStrings.serverProblem);
    } else if (statusCode >= 400 && statusCode <= 404) {
      try {
        final data = response?.data;
        if (data is Map<String, dynamic>) {
          if (data.containsKey('message')) {
            final message = data['message'].toString();
            return ServerFailure(message);
          }
        }
        return ServerFailure(AppStrings.somethingWentWrong);
      } catch (e) {
        return ServerFailure(AppStrings.somethingWentWrong);
      }
    } else {
      return ServerFailure(AppStrings.somethingWentWrong);
    }
  }
}
