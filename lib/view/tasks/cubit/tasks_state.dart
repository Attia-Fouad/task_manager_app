part of 'tasks_cubit.dart';

@immutable
sealed class TasksState {}

final class TasksInitial extends TasksState {}

final class GetTasksLoadingState extends TasksState {}

final class GetTasksSuccessState extends TasksState {}

final class GetTasksFailureState extends TasksState {
  final String message;

  GetTasksFailureState({required this.message});
}

final class AddNewTaskLoadingState extends TasksState {}

final class AddNewTaskSuccessState extends TasksState {}

final class AddNewTaskFailureState extends TasksState {
  final String message;

  AddNewTaskFailureState({required this.message});
}

final class EditTaskLoadingState extends TasksState {}

final class EditTaskSuccessState extends TasksState {}

final class EditTaskFailureState extends TasksState {
  final String message;

  EditTaskFailureState({required this.message});
}

final class DeleteTaskLoadingState extends TasksState {}

final class DeleteTaskSuccessState extends TasksState {}

final class DeleteTaskFailureState extends TasksState {
  final String message;

  DeleteTaskFailureState({required this.message});
}
