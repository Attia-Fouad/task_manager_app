import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_manager_app/core/networks/failures.dart';
import 'package:task_manager_app/core/networks/remote/api_constants.dart';
import 'package:task_manager_app/core/networks/remote/dio_helper.dart';
import 'package:task_manager_app/models/task_model.dart';
import 'package:task_manager_app/models/tasks_model.dart';
import 'package:task_manager_app/repositories/tasks_repo/remote_tasks_repo_impl.dart';

import 'remote_tasks_repo_impl_test.mocks.dart';

@GenerateMocks([DioHelper])
void main() {
  late RemoteTasksRepoImpl remoteTasksRepo;
  late MockDioHelper mockDioHelper;

  setUp(() {
    mockDioHelper = MockDioHelper();
    remoteTasksRepo = RemoteTasksRepoImpl(dioHelper: mockDioHelper);
  });

  group('RemoteTasksRepoImpl', () {
    group('getAllUserTasks', () {
      test('should return TasksModel when the response is successful',
          () async {
        // Arrange
        const userId = 1;
        const limit = 10;
        const skip = 0;
        final response = {
          'todos': [
            {
              'id': 1,
              'todo': 'Task 1',
              'completed': 0,
              'userId': 1,
            },
          ],
          'total': 1,
          'skip': 0,
          'limit': 10
        };
        when(mockDioHelper.getData(
          url: ApiConstants.getAllUserTasks(userId: userId),
          query: {'limit': limit, 'skip': skip},
        )).thenAnswer((_) async => Future.value(
              Response(
                data: response,
                statusCode: 200,
                requestOptions: RequestOptions(
                  path: ApiConstants.getAllUserTasks(userId: userId),
                ),
              ),
            ));

        // Act
        final result = await remoteTasksRepo.getAllUserTasks(
          userId: userId,
          limit: limit,
          skip: skip,
        );

        // Assert
        expect(result.isRight(), true);
        final tasksModel = result.getOrElse(
            () => TasksModel(todos: [], total: 0, skip: 0, limit: 0));
        expect(tasksModel.todos.length, 1);
        expect(tasksModel.total, 1);
        expect(tasksModel.skip, 0);
      });

      test('should return ServerFailure when an error occurs', () async {
        // Arrange
        const userId = 1;
        const limit = 10;
        const skip = 0;

        when(mockDioHelper.getData(
          url: ApiConstants.getAllUserTasks(userId: userId),
          query: {'limit': limit, 'skip': skip},
        )).thenThrow(DioException(
          requestOptions: RequestOptions(
            path: ApiConstants.getAllUserTasks(userId: userId),
          ),
        ));

        // Act
        final result = await remoteTasksRepo.getAllUserTasks(
          userId: userId,
          limit: limit,
          skip: skip,
        );

        // Assert
        expect(result.isLeft(), true);
        expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
      });
    });

    group('updateTasks', () {
      test('should return void when task is updated successfully', () async {
        // Arrange
        final task =
            TaskModel(id: 1, todo: 'Task 1', completed: true, userId: 1);
        when(mockDioHelper.patchData(
          url: ApiConstants.task(taskId: task.id),
          data: {
            "completed": task.completed,
          },
        )).thenAnswer((_) async => Future.value(Response(
              data: task,
              statusCode: 200,
              requestOptions: RequestOptions(
                path: ApiConstants.task(taskId: task.id),
              ),
            )));

        // Act
        final result = await remoteTasksRepo.updateTasks(task: task);

        // Assert
        expect(result.isRight(), true);
      });

      test('should return ServerFailure when update fails', () async {
        // Arrange
        final task =
            TaskModel(id: 1, todo: 'Task 1', completed: true, userId: 1);
        when(mockDioHelper
            .patchData(url: ApiConstants.task(taskId: task.id), data: {
          "completed": task.completed,
        })).thenThrow(DioException(
          requestOptions: RequestOptions(
            path: ApiConstants.task(taskId: task.id),
          ),
        ));

        // Act
        final result = await remoteTasksRepo.updateTasks(task: task);

        // Assert
        expect(result.isLeft(), true);
        expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
      });
    });

    group('deleteTasks', () {
      test('should return void when task is deleted successfully', () async {
        // Arrange
        final task =
            TaskModel(id: 1, todo: 'Task 1', completed: false, userId: 1);
        when(mockDioHelper.deleteData(
          url: ApiConstants.task(taskId: task.id),
        )).thenAnswer((_) async => Future.value(
              Response(
                data: {},
                statusCode: 200,
                requestOptions: RequestOptions(
                  path: ApiConstants.task(taskId: task.id),
                ),
              ),
            ));

        // Act
        final result = await remoteTasksRepo.deleteTasks(task: task);

        // Assert
        expect(result.isRight(), true);
      });

      test('should return ServerFailure when delete fails', () async {
        // Arrange
        final task =
            TaskModel(id: 1, todo: 'Task 1', completed: false, userId: 1);
        when(mockDioHelper.deleteData(
          url: ApiConstants.task(taskId: task.id),
        )).thenThrow(DioException(
          requestOptions: RequestOptions(
            path: ApiConstants.task(taskId: task.id),
          ),
        ));

        // Act
        final result = await remoteTasksRepo.deleteTasks(task: task);

        // Assert
        expect(result.isLeft(), true);
        expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
      });
    });

    group('addNewTasks', () {
      test('should return TaskModel when a new task is added successfully',
          () async {
        // Arrange
        const taskTitle = 'New Task';
        const userId = 1;
        final response = {
          'id': 1,
          'todo': 'New Task',
          'completed': false,
          'userId': 1,
        };
        when(mockDioHelper.postData(
              url: ApiConstants.addTask,
              data: {
                "todo": taskTitle,
                "userId": userId,
                "completed": false,
              },
            )).thenAnswer((_) async => Future.value(
            Response(
              data: response,
              statusCode: 201,
              requestOptions: RequestOptions(path: ApiConstants.addTask,),
            )
        ));

        // Act
        final result = await remoteTasksRepo.addNewTasks(
          taskTitle: taskTitle,
          userId: userId,
        );

        // Assert
        expect(result.isRight(), true);
        final task = result.getOrElse(
            () => TaskModel(id: 0, todo: '', completed: false, userId: 0));
        expect(task.todo, 'New Task');
        expect(task.completed, false);
        expect(task.userId, 1);
      });

      test('should return ServerFailure when adding task fails', () async {
        // Arrange
        const taskTitle = 'New Task';
        const userId = 1;
        when(mockDioHelper.postData(
          url: ApiConstants.addTask,
          data: {
            "todo": taskTitle,
            "userId": userId,
            "completed": false,
          },
            )).thenThrow(DioException(
          requestOptions: RequestOptions(path: ApiConstants.addTask,),
        ));

        // Act
        final result = await remoteTasksRepo.addNewTasks(
          taskTitle: taskTitle,
          userId: userId,
        );

        // Assert
        expect(result.isLeft(), true);
        expect(result.fold((l) => l, (r) => null), isA<ServerFailure>());
      });
    });
  });
}
