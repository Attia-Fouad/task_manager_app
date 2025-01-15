import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final int id;
  final String todo;
  bool completed;
  final int userId;

  TaskModel(
      {required this.id,
      required this.todo,
      required this.completed,
      required this.userId});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      todo: json['todo'],
      completed:
          json['completed'] is num ? json['completed'] == 1 : json['completed'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson({bool saveLocal = false}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['todo'] = todo;
    data['completed'] = completed == true ? 1 : 0;
    data['userId'] = userId;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        todo,
        completed,
        userId,
      ];
}
