import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../core/networks/failures.dart';
import '../../core/networks/remote/api_constants.dart';
import '../../core/networks/remote/dio_helper.dart';
import '../../models/tasks_model.dart';
import 'remote_tasks_repo.dart';

class RemoteTasksRepoImpl implements RemoteTasksRepo {
  @override
  Future<Either<Failure, TasksModel>> getAllUserTasks({
    required num userId,
    int? limit,
    int? skip,
  }) async {
    try {
      var response = await DioHelper.getData(
        url: ApiConstants.getAllUserTasks(userId: userId),
        query: {
          if (limit != null) "limit": limit,
          if (skip != null) "skip": skip,
        },
      );
      if (response.statusCode == 200) {
        return right(TasksModel.fromJson(response.data));
      }
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioError(error));
      }
      if (kDebugMode) {
        print("Error when getAllUserTasks $error");
      }
    }
    return left(ServerFailure(''));
  }
}
