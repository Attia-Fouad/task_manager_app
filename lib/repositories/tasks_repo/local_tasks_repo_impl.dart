import 'package:sqflite/sqflite.dart';
import '../../models/task_model.dart';
import 'local_tasks_repo.dart';

class LocalTasksRepoImpl implements LocalTasksRepo {
  final Database db;

  LocalTasksRepoImpl({required this.db});

  @override
  Future<void> insertTasks(List<TaskModel> tasks) async {
    final batch = db.batch();
    for (final task in tasks) {
      batch.insert('tasks', task.toJson());
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    final tasks = await db.query('tasks');
    return tasks.map((json) => TaskModel.fromJson(json)).toList();
  }

  @override
  Future<int> deleteAllTasks() async {
    return await db.delete('tasks');
  }
}
