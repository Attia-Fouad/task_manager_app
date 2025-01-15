import 'package:dartz/dartz.dart';
import 'package:task_manager_app/models/task_model.dart';
import '../../core/networks/failures.dart';
import '../../models/tasks_model.dart';

abstract class RemoteTasksRepo {
  Future<Either<Failure, TasksModel>> getAllUserTasks({
    required num userId,
    int? limit,
    int? skip,
  });

  Future<Either<Failure, void>> updateTasks({
    required TaskModel task,
  });

  Future<Either<Failure, void>> deleteTasks({
    required TaskModel task,
  });

  Future<Either<Failure, TaskModel>> addNewTasks({required String taskTitle,required num userId});
}
