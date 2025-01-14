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
