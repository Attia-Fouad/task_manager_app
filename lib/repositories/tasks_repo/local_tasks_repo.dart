import 'package:task_manager_app/models/task_model.dart';

abstract class LocalTasksRepo {
  Future<void> insertTasks(List<TaskModel> tasks);
  Future<List<TaskModel>> getTasks();
  Future<int> deleteAllTasks();
}
