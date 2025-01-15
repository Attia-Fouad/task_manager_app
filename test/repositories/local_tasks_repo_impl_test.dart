import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager_app/models/task_model.dart';
import 'package:task_manager_app/repositories/tasks_repo/local_tasks_repo_impl.dart';

import 'local_tasks_repo_impl_test.mocks.dart';

@GenerateMocks([Database, Batch])
void main() {
  late MockDatabase mockDatabase;
  late LocalTasksRepoImpl localTasksRepo;

  setUp(() {
    mockDatabase = MockDatabase();
    localTasksRepo = LocalTasksRepoImpl(db: mockDatabase);
  });

  group('LocalTasksRepoImpl', () {
    test('insertTasks should insert all tasks using batch', () async {
      final tasks = [
        TaskModel(id: 1, todo: 'Task 1', completed: false, userId: 1),
        TaskModel(id: 2, todo: 'Task 2', completed: true, userId: 2),
      ];

      // Mock the batch and its behavior
      final mockBatch = MockBatch();
      when(mockDatabase.batch()).thenReturn(mockBatch);
      when(mockBatch.commit(
        exclusive: anyNamed('exclusive'),
        noResult: anyNamed('noResult'),
        continueOnError: anyNamed('continueOnError'),
      )).thenAnswer((_) async => []);

      // Call the method
      await localTasksRepo.insertTasks(tasks);

      // Verify the insert operations
      for (final task in tasks) {
        verify(mockBatch.insert('tasks', task.toJson())).called(1);
      }

      // Verify batch commit
      verify(mockBatch.commit(
        exclusive: anyNamed('exclusive'),
        noResult: true,
        continueOnError: anyNamed('continueOnError'),
      )).called(1);
    });
  });
}
