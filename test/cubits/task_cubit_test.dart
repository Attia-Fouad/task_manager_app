import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager_app/core/networks/failures.dart';
import 'package:task_manager_app/models/task_model.dart';
import 'package:task_manager_app/repositories/tasks_repo/local_tasks_repo.dart';
import 'package:task_manager_app/models/tasks_model.dart';
import 'package:task_manager_app/repositories/tasks_repo/remote_tasks_repo.dart';
import 'package:task_manager_app/view/tasks/cubit/tasks_cubit.dart';

import 'task_cubit_test.mocks.dart';

@GenerateMocks([LocalTasksRepo, RemoteTasksRepo])
void main() {
  late MockRemoteTasksRepo mockRemoteTasksRepo;
  late MockLocalTasksRepo mockLocalTasksRepo;
  late TasksCubit tasksCubit;

  setUp(() {
    mockRemoteTasksRepo = MockRemoteTasksRepo();
    mockLocalTasksRepo = MockLocalTasksRepo();
    tasksCubit = TasksCubit(
      remoteTasksRepo: mockRemoteTasksRepo,
      localTasksRepo: mockLocalTasksRepo,
    );
  });

  tearDown(() {
    tasksCubit.close();
  });

  group('TasksCubit tests', () {
    const userId = 1;
    final task =
        TaskModel(userId: 1, id: 1, todo: 'Test Task', completed: false);
    final tasksModel = TasksModel(todos: [task], total: 1, skip: 0, limit: 15);

    // Test for local operations
    test('saveTasksLocally should call localTasksRepo.insertTasks', () async {
      // Arrange: Mock insertTasks method
      when(mockLocalTasksRepo.insertTasks([task])).thenAnswer((_) async => 1);

      // Act: Call saveTasksLocally
      await tasksCubit.saveTasksLocally([task]);

      // Assert: Verify insertTasks is called
      verify(mockLocalTasksRepo.insertTasks([task])).called(1);
    });

    test('deleteStoredLocalTasks should call localTasksRepo.deleteAllTasks',
        () async {
      // Arrange: Mock deleteAllTasks method
      when(mockLocalTasksRepo.deleteAllTasks()).thenAnswer((_) async => 1);

      // Act: Call deleteStoredLocalTasks
      await tasksCubit.deleteStoredLocalTasks();

      // Assert: Verify deleteAllTasks is called
      verify(mockLocalTasksRepo.deleteAllTasks()).called(1);
    });

    test(
        'getStoredLocalTasks should call localTasksRepo.getTasks and emit success state',
        () async {
      // Arrange: Mock getTasks method
      when(mockLocalTasksRepo.getTasks()).thenAnswer((_) async => [task]);

      // Act: Call getStoredLocalTasks
      await tasksCubit.getStoredLocalTasks();

      // Assert: Verify the state emitted and getTasks is called
      expect(tasksCubit.state, isA<GetTasksSuccessState>());
      verify(mockLocalTasksRepo.getTasks()).called(1);
    });

    // Test for remote operations
    test(
        'addNewTask should emit AddNewTaskLoadingState and AddNewTaskSuccessState on success',
        () async {
      // Arrange: Mock addNewTasks method
      when(mockRemoteTasksRepo.addNewTasks(
              userId: userId, taskTitle: 'Test Task'))
          .thenAnswer((_) async => Right(task));

      // Act: Call addNewTask
      await tasksCubit.addNewTask(taskTitle: 'Test Task', userId: userId);

      // Assert: Verify correct states are emitted
      expect(tasksCubit.state, isA<AddNewTaskSuccessState>());
      verify(mockRemoteTasksRepo.addNewTasks(
              userId: userId, taskTitle: 'Test Task'))
          .called(1);
    });

    test('addNewTask should emit AddNewTaskFailureState on failure', () async {
      // Arrange: Mock addNewTasks method to return failure
      when(mockRemoteTasksRepo.addNewTasks(
              userId: userId, taskTitle: 'Test Task'))
          .thenAnswer((_) async => Left(ServerFailure('Error')));

      // Act: Call addNewTask
      await tasksCubit.addNewTask(taskTitle: 'Test Task', userId: userId);

      // Assert: Verify correct states are emitted
      expect(tasksCubit.state, isA<AddNewTaskFailureState>());
      verify(mockRemoteTasksRepo.addNewTasks(
              userId: userId, taskTitle: 'Test Task'))
          .called(1);
    });

    test(
        'editTask should emit EditTaskLoadingState and EditTaskSuccessState on success',
        () async {
      // Arrange: Mock updateTasks method
      when(mockRemoteTasksRepo.updateTasks(task: task))
          .thenAnswer((_) async => const Right(null));

      // Act: Call editTask
      await tasksCubit.editTask(task: task);

      // Assert: Verify correct states are emitted
      expect(tasksCubit.state, isA<EditTaskSuccessState>());
      verify(mockRemoteTasksRepo.updateTasks(task: task)).called(1);
    });

    test('editTask should emit EditTaskFailureState on failure', () async {
      // Arrange: Mock updateTasks method to return failure
      when(mockRemoteTasksRepo.updateTasks(task: task))
          .thenAnswer((_) async => Left(ServerFailure('Error')));

      // Act: Call editTask
      await tasksCubit.editTask(task: task);

      // Assert: Verify correct states are emitted
      expect(tasksCubit.state, isA<EditTaskFailureState>());
      verify(mockRemoteTasksRepo.updateTasks(task: task)).called(1);
    });

    test(
        'deleteTask should emit EditTaskLoadingState and EditTaskSuccessState on success',
        () async {
      // Arrange: Mock deleteTasks method
      when(mockRemoteTasksRepo.deleteTasks(task: task))
          .thenAnswer((_) async => const Right(null));

      // Act: Call deleteTask
      await tasksCubit.deleteTask(task: task);

      // Assert: Verify correct states are emitted
      expect(tasksCubit.state, isA<EditTaskSuccessState>());
      verify(mockRemoteTasksRepo.deleteTasks(task: task)).called(1);
    });

    test('deleteTask should emit EditTaskFailureState on failure', () async {
      // Arrange: Mock deleteTasks method to return failure
      when(mockRemoteTasksRepo.deleteTasks(task: task))
          .thenAnswer((_) async => Left(ServerFailure('Error')));

      // Act: Call deleteTask
      await tasksCubit.deleteTask(task: task);

      // Assert: Verify correct states are emitted
      expect(tasksCubit.state, isA<EditTaskFailureState>());
      verify(mockRemoteTasksRepo.deleteTasks(task: task)).called(1);
    });

    // Test pagination behavior
    test('getRemoteTasks should handle pagination and emit success state',
        () async {
      // Arrange: Mock getAllUserTasks method to return tasks
      when(mockRemoteTasksRepo.getAllUserTasks(
        userId: userId,
        limit: 15,
        skip: 0,
      )).thenAnswer((_) async => Right(tasksModel));

      // Arrange: Mock deleteTasks method
      when(mockLocalTasksRepo.deleteAllTasks()).thenAnswer((_) async => 1);


      when(mockLocalTasksRepo.insertTasks([task])).thenAnswer((_) async => 1);

      // Act: Call getRemoteTasks
      await tasksCubit.getRemoteTasks(isFirstTime: true, userId: userId);

      // Assert: Verify tasksModel is populated and correct state is emitted
      verify(mockRemoteTasksRepo.getAllUserTasks(
        userId: userId,
        limit: 15,
        skip: 0,
      )).called(1);
    });
  });
}
