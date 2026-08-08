import 'task.dart';

class NormalTask extends Task {
  NormalTask(super.title, super.priority, super.deadline, super.status);

  @override
  String get taskType => 'normal';

  @override
  String taskDetails() {
    return "Task: $title | "
        "Priority: ${priority.name} | "
        "Deadline: $deadline | "
        "Status: ${status.name}";
  }

  factory NormalTask.fromJson(Map<String, dynamic> json) {
    return NormalTask(
      json['title'] as String,
      Priority.values.firstWhere(
        (priority) => priority.name == json['priority'],
      ),
      json['deadline'] as String,
      Status.values.firstWhere((status) => status.name == json['status']),
    );
  }
}
