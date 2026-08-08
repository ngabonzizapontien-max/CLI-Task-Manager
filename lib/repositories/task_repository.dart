import 'package:task_manager/models/task.dart';
import 'package:task_manager/repositories/repository.dart';

class TaskRepository implements Repository<Task> {
  final List<Task> _tasks = [];

  @override
  void add(Task task) {
    _tasks.add(task);
  }

  @override
  List<Task> getAll() {
    return List.unmodifiable(_tasks);
  }

  @override
  void delete(int index) {
    if (index < 0 || index >= _tasks.length) {
      throw RangeError.index(
        index,
        _tasks,
        'index',
        'Invalid task index',
      );
    }

    _tasks.removeAt(index);
  }
}
