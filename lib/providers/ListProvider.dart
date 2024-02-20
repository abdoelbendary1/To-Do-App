import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app1/firebaseUtils.dart';
import 'package:todo_app1/model/task.dart';

class ListProvider extends ChangeNotifier {
  List<Task> tasksList = [];

  DateTime selectedDate = DateTime.now();
  void getTasksList() async {
    QuerySnapshot<Task> querySnapshot =
        await FireBaseUtils.getTasksCollection().orderBy("dateTime").get();
    //return list of tasks
    List<Task> tasksList = querySnapshot.docs.map((doc) => doc.data()).toList();

    // tasksList = await FireBaseUtils.getAllTasks();
    tasksList = tasksList.where((task) {
      if (selectedDate.day == task.dateTime?.day &&
          selectedDate.month == task.dateTime?.month &&
          selectedDate.year == task.dateTime?.year) {
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
  }
}
