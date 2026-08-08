import 'dart:io';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/services/task_service.dart';

void main(List<String> arguments) {
  print('Ngapo in Dart Programming language\n');

  print("""
**********THIS IS A TO DO LIST APPLICATION**********
""");

  headerMessage();
  bool isRunning = true;

  while (isRunning) {
    print("Choose: ");
    String choice = stdin.readLineSync()!;
    switch (choice) {
      case "1":
        addTask();
        headerMessage(); // Display the header message after adding a task
        break;

      case "2":
        viewTasks();
        headerMessage(); // Display the header message after viewing tasks
        break;

      case "3":
        List<Task> tasks = taskService
            .getAllTasks(); // list of all tasks created
        print("Which task do you want to mark as done? "); //message to the user
        int number = int.parse(stdin.readLineSync()!); //user access
        taskService.markTaskAsDone(
          number - 1,
        ); // Mark the task as done using the index
        if (number > 0 && number <= tasks.length) {
          print("Task marked as done.");
        } else {
          print("Invalid task number.");
        }
        headerMessage(); // Display the header message after marking a task as done
        break;

      case "4":
        delTaskFromUser();
        headerMessage(); // Display the header message after deleting a task
        break;

      case "5":
        isRunning = false;
        print("Thanks for using our service!");
        break;
      default:
        print("Invalid choice");
    }
  }
}

final TaskService taskService = TaskService();

void readTaskFromUser() {
  print("\nEnter the name of task");
  String title = stdin.readLineSync()!;

  print("How do you want to quality your task? [High, Medium, Low]");
  String priorityUI = stdin.readLineSync()!.trim().toLowerCase();
  Priority priority = Priority.medium; //default priority
  if (priorityUI == 'high') {
    priority = Priority.high;
  } else if (priorityUI == 'low') {
    priority = Priority.low;
  }

  print("What is the deadline of this task? [23-08-2026]");
  String deadline = stdin.readLineSync()!;

  taskService.createTask(title, priority, deadline);
  print("Task created Successfully!");
}

void delTaskFromUser() {
  viewTasks(); // Display the list of tasks before deletion
  List<Task> tasks = taskService.getAllTasks(); // list of all tasks created
  print("Which task do you want to delete? "); //message to the user
  int number = int.parse(stdin.readLineSync()!); //user access

  //check the number on the of available elements in my list
  if (number > 0 && number <= tasks.length) {
    int i = number - 1; // to access the index of the list
    taskService.deleteTask(i);
    print("Task deleted.");
  } else {
    print("Invalid task number");
    return;
  }
  print("\n");
  print("The updated list of tasks is the following");
  List<Task> updatedTasks = taskService
      .getAllTasks(); // list of all tasks updated
  print("The updated list of tasks is the following");

  for (int i = 0; i < updatedTasks.length; i++) {
    print("${i + 1}. ${updatedTasks[i].taskDetails()}");
  }
}

void addTask() {
  readTaskFromUser();
  // The user is asked if he/she wanna add a multiple tasks or not.
  while (true) {
    print("Do you want to add an other task? Y or N");
    String answer = stdin.readLineSync()!;
    if (answer.toLowerCase() == "y") {
      readTaskFromUser();
    } else {
      break;
    }
  }
}

void headerMessage() {
  print("""
  1. Add task
  2. View tasks
  3. mark a task as done
  4. Delete a task
  5. Exit
  """);
}

void viewTasks() {
  List<Task> tasks = taskService.getAllTasks(); // list of all tasks created
  if (tasks.isEmpty) {
    print("No tasks available.");
    return;
  }
  for (int i = 0; i < tasks.length; i++) {
    print("${i + 1}. ${tasks[i].taskDetails()}");
  }
}
