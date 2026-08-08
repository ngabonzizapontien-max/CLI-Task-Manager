import 'dart:convert';
import 'dart:io';

import 'package:task_manager/models/task.dart';
import 'package:task_manager/models/normal_task.dart';
import 'package:task_manager/models/urgent_task.dart';

class JsonStorage {
  final File file = File('data/tasks.json');

  JsonStorage();

  // ------------------------------------------------------------
  // SAVE TASKS
  // ------------------------------------------------------------

  Future<void> saveTasks(List<Task> tasks) async {
    final List<Map<String, dynamic>> jsonData = tasks.map((task) {
      final Map<String, dynamic> data = task.toJson();

      if (task is UrgentTask) {
        data['type'] = 'urgent';
      } else if (task is NormalTask) {
        data['type'] = 'normal';
      }

      return data;
    }).toList();

    final String jsonString = jsonEncode(jsonData);

    await file.parent.create(recursive: true);

    await file.writeAsString(jsonString);
  }

  // ------------------------------------------------------------
  // LOAD TASKS
  // ------------------------------------------------------------

  Future<List<Task>> loadTasks() async {
    if (!await file.exists()) {
      return [];
    }

    final String jsonString = await file.readAsString();

    if (jsonString.trim().isEmpty) {
      return [];
    }

    final dynamic decodedData = jsonDecode(jsonString);

    if (decodedData is! List) {
      throw const FormatException('Invalid tasks.json format.');
    }

    final List<Task> tasks = [];

    for (final dynamic item in decodedData) {
      if (item is! Map<String, dynamic>) {
        throw const FormatException('Invalid task data.');
      }

      final String? type = item['type'];

      switch (type) {
        case 'urgent':
          tasks.add(UrgentTask.fromJson(item));
          break;

        case 'normal':
          tasks.add(NormalTask.fromJson(item));
          break;

        default:
          throw FormatException('Unknown task type: $type');
      }
    }

    return tasks;
  }
}
