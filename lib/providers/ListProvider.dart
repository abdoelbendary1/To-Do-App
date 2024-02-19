import 'package:flutter/material.dart';
import 'package:todo_app1/firebaseUtils.dart';
import 'package:todo_app1/model/task.dart';

class ListProvider extends ChangeNotifier {
  List<Task> tasksList = [];
  DateTime selectedDate = DateTime.now();
  void getTasksList() async {
    List<Task> allTasksList = await FireBaseUtils.getAllTasks();
    tasksList = allTasksList.where((task) {
      if (selectedDate.day == task.dateTime.day &&
          selectedDate.month == task.dateTime.month &&
          selectedDate.year == task.dateTime.year) {
        return true;
      } else {
        return false;
      }
    }).toList();

    // tasksList.sort((task1, task2) => task1.dateTime.compareTo(task2.dateTime));
    notifyListeners();
  }

  void changeSelectedDay(DateTime newSelectedDate) {
    selectedDate = newSelectedDate;
    // refresh tasks list with filtering
    getTasksList();
    notifyListeners();
  }
}
