import 'package:task_manager/models/task.dart';
import 'package:task_manager/models/normal_task.dart';
import 'package:task_manager/models/urgent_task.dart';
import 'package:task_manager/repositories/task_repository.dart';
import 'package:task_manager/storage/json_storage.dart';
import 'package:task_manager/exceptions/task_exception.dart';

class TaskService {
  final TaskRepository _repository = TaskRepository();
  final JsonStorage _storage = JsonStorage();

  // ------------------------------------------------------------
  // LOAD TASKS
  // ------------------------------------------------------------

  Future<void> loadTasks() async {
    final List<Task> tasks = await _storage.loadTasks();

    for (final Task task in tasks) {
      _repository.add(task);
    }
  }

  // ------------------------------------------------------------
  // CREATE TASK
  // ------------------------------------------------------------

  Future<void> createTask(
    String title,
    Priority priority,
    String deadline,
  ) async {
    // Validate title
    if (title.trim().isEmpty) {
      throw TaskException('Task title cannot be empty.');
    }

    final Task task;

    // High priority = UrgentTask
    if (priority == Priority.high) {
      task = UrgentTask(title, priority, deadline, Status.pending);
    } else {
      // Medium/Low = NormalTask
      task = NormalTask(title, priority, deadline, Status.pending);
    }

    _repository.add(task);

    // Save ALL tasks.
    await _storage.saveTasks(_repository.getAll());
  }

  // ------------------------------------------------------------
  // MARK TASK AS DONE
  // ------------------------------------------------------------

  Future<void> markTaskAsDone(int index) async {
    final List<Task> tasks = _repository.getAll();

    _validateIndex(index, tasks);

    final Task task = tasks[index];

    // Don't mark an already completed task again.
    if (task.status == Status.done) {
      throw TaskException('Task is already marked as done.');
    }

    task.status = Status.done;

    // Save ALL tasks.
    await _storage.saveTasks(_repository.getAll());
  }

  // ------------------------------------------------------------
  // DELETE TASK
  // ------------------------------------------------------------

  Future<void> deleteTask(int index) async {
    final List<Task> tasks = _repository.getAll();

    _validateIndex(index, tasks);

    _repository.delete(index);

    // Save ALL remaining tasks.
    await _storage.saveTasks(_repository.getAll());
  }

  // ------------------------------------------------------------
  // GET ALL TASKS
  // ------------------------------------------------------------

  List<Task> getAllTasks() {
    return _repository.getAll();
  }

  // ------------------------------------------------------------
  // VALIDATE INDEX
  // ------------------------------------------------------------

  void _validateIndex(int index, List<Task> tasks) {
    if (index < 0 || index >= tasks.length) {
      throw TaskException('Invalid task index.');
    }
  }
}
