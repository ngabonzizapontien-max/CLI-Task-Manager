enum Priority { high, medium, low }

enum Status { pending, done }

abstract class Task {
  String title;
  Priority priority;
  String deadline;
  Status status;

  Task(this.title, this.priority, this.deadline, this.status);

  String taskDetails();

  /// Identifies the concrete type of task.
  /// Subclasses can override this value.
  String get taskType => 'normal';

  /// Converts the task into JSON-compatible data.
  Map<String, dynamic> toJson() {
    return {
      'type': taskType,
      'title': title,
      'priority': priority.name,
      'deadline': deadline,
      'status': status.name,
    };
  }
}
