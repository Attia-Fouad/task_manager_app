import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../constants.dart';
import 'api_constants.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        }));
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

   getData({
    required String url,
    String? lang,
    query,
    bool sendToken = false,
    data,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      if (sendToken) 'Authorization': "Bearer ${await getToken()}",
    };

    return await dio.get(
      data: data,
      url,
      queryParameters: query,
    );
  }

   postData({
    required String url,
    String? lang,
    query,
    data,
    bool sendToken = false,
    cancelToken,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      if (sendToken) 'Authorization': "Bearer ${await getToken()}",
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

   patchData({
    required String url,
    query,
    data,
    bool sendToken = false,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      if (sendToken) 'Authorization': "Bearer ${await getToken()}",
    };
    return await dio.patch(
      url,
      queryParameters: query,
      data: data,
    );
  }

   deleteData({
    required String url,
    String? lang,
    query,
    data,
    bool sendToken = false,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      if (sendToken) 'Authorization': "Bearer ${await getToken()}",
    };
    return await dio.delete(
      url,
      queryParameters: query,
      data: data,
    );
  }

   putData({
    required String url,
    String? lang,
    query,
    required data,
    bool sendToken = false,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      if (sendToken) 'Authorization': "Bearer ${await getToken()}",
    };
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
