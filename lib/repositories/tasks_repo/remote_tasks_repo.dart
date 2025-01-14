import 'package:dartz/dartz.dart';
import '../../core/networks/failures.dart';
import '../../models/tasks_model.dart';

abstract class RemoteTasksRepo {
  Future<Either<Failure, TasksModel>> getAllUserTasks({
    required num userId,
     int? limit,
     int? skip,
  });

}
