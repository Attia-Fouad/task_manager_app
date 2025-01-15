import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../core/networks/failures.dart';
import '../../core/networks/remote/api_constants.dart';
import '../../core/networks/remote/dio_helper.dart';
import '../../models/task_model.dart';
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

  @override
  Future<Either<Failure, void>> updateTasks({
    required TaskModel task,
  }) async {
    try {
      var response = await DioHelper.patchData(
          url: ApiConstants.task(taskId: task.id),
          data: {
            "completed": task.completed,
          });
      if (response.statusCode == 200) {
        return right(null);
      }
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioError(error));
      }
      if (kDebugMode) {
        print("Error when updateTasks $error");
      }
    }
    return left(ServerFailure(''));
  }

  @override
  Future<Either<Failure, void>> deleteTasks({
    required TaskModel task,
  }) async {
    try {
      var response = await DioHelper.deleteData(
        url: ApiConstants.task(taskId: task.id),
      );
      if (response.statusCode == 200) {
        return right(null);
      }
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioError(error));
      }
      if (kDebugMode) {
        print("Error when updateTasks $error");
      }
    }
    return left(ServerFailure(''));
  }

  @override
  Future<Either<Failure, TaskModel>> addNewTasks(
      {required String taskTitle, required num userId}) async {
    try {
      var response = await DioHelper.postData(url: ApiConstants.addTask, data: {
        "todo": taskTitle,
        "userId": userId,
        "completed": false,
      });
      if (response.statusCode == 201) {
        return right(TaskModel.fromJson(response.data));
      }
    } catch (error) {
      if (error is DioException) {
        return left(ServerFailure.fromDioError(error));
      }
      if (kDebugMode) {
        print("Error when addNewTasks $error");
      }
    }
    return left(ServerFailure(''));
  }
}
