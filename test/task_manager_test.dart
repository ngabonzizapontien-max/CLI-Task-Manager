import 'package:test/test.dart';

import 'package:task_manager/models/task.dart';
import 'package:task_manager/models/normal_task.dart';
import 'package:task_manager/models/urgent_task.dart';
import 'package:task_manager/services/task_service.dart';
import 'package:task_manager/exceptions/task_exception.dart';

void main() {
  late TaskService taskService;

  setUp(() {
    taskService = TaskService();
  });

  group('Task creation', () {
    test('creates a NormalTask for medium priority', () async {
      await taskService.createTask('Study Dart', Priority.medium, '23-08-2026');

      final tasks = taskService.getAllTasks();

      expect(tasks.length, 1);
      expect(tasks.first, isA<NormalTask>());
      expect(tasks.first.title, 'Study Dart');
      expect(tasks.first.priority, Priority.medium);
      expect(tasks.first.status, Status.pending);
    });

    test('creates an UrgentTask for high priority', () async {
      await taskService.createTask(
        'Finish homework',
        Priority.high,
        '23-08-2026',
      );

      final tasks = taskService.getAllTasks();

      expect(tasks.length, 1);
      expect(tasks.first, isA<UrgentTask>());
      expect(tasks.first.title, 'Finish homework');
      expect(tasks.first.priority, Priority.high);
      expect(tasks.first.status, Status.pending);
    });

    test('rejects an empty task title', () async {
      expect(
        () => taskService.createTask('', Priority.medium, '23-08-2026'),
        throwsA(isA<TaskException>()),
      );
    });
  });

  group('Task status', () {
    test('marks a pending task as done', () async {
      await taskService.createTask(
        'Learn generics',
        Priority.medium,
        '24-08-2026',
      );

      await taskService.markTaskAsDone(0);

      final tasks = taskService.getAllTasks();

      expect(tasks.first.status, Status.done);
    });

    test('throws TaskException for an invalid task index', () async {
      expect(
        () => taskService.markTaskAsDone(999),
        throwsA(isA<TaskException>()),
      );
    });

    test('throws TaskException when task is already done', () async {
      await taskService.createTask(
        'Learn exceptions',
        Priority.low,
        '25-08-2026',
      );

      await taskService.markTaskAsDone(0);

      expect(
        () => taskService.markTaskAsDone(0),
        throwsA(isA<TaskException>()),
      );
    });
  });

  group('Task deletion', () {
    test('deletes a task successfully', () async {
      await taskService.createTask(
        'Task to delete',
        Priority.low,
        '26-08-2026',
      );

      expect(taskService.getAllTasks().length, 1);

      await taskService.deleteTask(0);

      expect(taskService.getAllTasks(), isEmpty);
    });

    test('throws TaskException when deleting an invalid index', () async {
      expect(() => taskService.deleteTask(999), throwsA(isA<TaskException>()));
    });
  });
}
