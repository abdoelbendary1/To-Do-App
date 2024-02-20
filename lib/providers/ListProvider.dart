import 'package:flutter/material.dart';
import 'package:todo_app1/firebaseUtils.dart';
import 'package:todo_app1/model/task.dart';

class ListProvider extends ChangeNotifier {
  List<Task> tasksList = [];
  DateTime selectedDate = DateTime.now();
  void getTasksList() async {
    tasksList = await FireBaseUtils.getAllTasks();
    tasksList = tasksList.where((task) {
      if (selectedDate.day == task.dateTime!.day &&
          selectedDate.month == task.dateTime!.month &&
          selectedDate.year == task.dateTime!.year) {
        return true;
      } else {
        return false;
      }
    }).toList();

    notifyListeners();
  }

  void changeSelectedDay(DateTime newSelectedDate) {
    selectedDate = newSelectedDate;
    // refresh tasks list with filtering
    getTasksList();
    notifyListeners();
  }

  Future<void> updateTaskIsDone(Task task) async {
    await FireBaseUtils.getTasksCollection()
        .doc(task.id)
        .update({'isDone': true})
        .timeout(
          Duration(
            milliseconds: 300,
          ),
          onTimeout: () => getTasksList(),
        )
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updateTaskDetails(Task task) async {
    if (task.id!.isEmpty) {
      print("Updated");
      await FireBaseUtils.getTasksCollection()
          .doc(task.id)
          .update(task.toFireStore())
          .timeout(
            Duration(
              milliseconds: 300,
            ),
            onTimeout: () => getTasksList(),
          )
          .catchError((error) => print("Failed to update user: $error"));
    }
  }
}
