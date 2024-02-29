import 'package:flutter/material.dart';
import 'package:todo_app1/firebaseUtils.dart';
import 'package:todo_app1/model/task.dart';

class ListProvider extends ChangeNotifier {
  List<Task> tasksList = [];
  DateTime selectedDate = DateTime.now();
  void getTasksList(String? uID) async {
    tasksList = await FireBaseUtils.getAllTasks(uID);
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

  void changeSelectedDay(DateTime newSelectedDate, String? uID) {
    selectedDate = newSelectedDate;
    // refresh tasks list with filtering
    getTasksList(uID);
    notifyListeners();
  }

  Future<void> updateTaskIsDone(Task task, String? uID) async {
    await FireBaseUtils.getTasksCollection(uID)
        .doc(task.id)
        .update({'isDone': true})
        .timeout(
          Duration(
            milliseconds: 300,
          ),
          onTimeout: () => getTasksList(uID),
        )
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> updateTaskDetails(Task task, String? uID) async {
    await FireBaseUtils.getTasksCollection(uID)
        .doc(task.id)
        .update(task.toFireStore())
        .then(
          (value) => getTasksList(uID),
        )
        .timeout(
          Duration(
            milliseconds: 300,
          ),
          onTimeout: () => getTasksList(uID),
        )
        .catchError((error) => print("Failed to update user: $error"));
    print("Edited");
  }
}
