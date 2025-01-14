import 'package:task_manager_app/models/task_model.dart';

class TasksModel {
  final List<TaskModel> todos;
  final int total;
  final int skip;
  final int limit;

  TasksModel({
    required this.todos,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory TasksModel.fromJson(Map<String, dynamic> json) {
    return TasksModel(
      todos: (json['todos'] as List).map((i) => TaskModel.fromJson(i)).toList(),
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['todos'] = todos.map((v) => v.toJson()).toList();
    data['total'] = total;
    data['skip'] = skip;
    data['limit'] = limit;
    return data;
  }
}
