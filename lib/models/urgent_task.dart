import 'task.dart';

class UrgentTask extends Task {
  UrgentTask(super.title, super.priority, super.deadline, super.status);

  @override
  String get taskType => 'urgent';

  @override
  String taskDetails() {
    return "🚨 URGENT | "
        "Task: $title | "
        "Priority: ${priority.name} | "
        "Deadline: $deadline | "
        "Status: ${status.name}";
  }

  factory UrgentTask.fromJson(Map<String, dynamic> json) {
    return UrgentTask(
      json['title'] as String,
      Priority.values.firstWhere(
        (priority) => priority.name == json['priority'],
      ),
      json['deadline'] as String,
      Status.values.firstWhere((status) => status.name == json['status']),
    );
  }
}
