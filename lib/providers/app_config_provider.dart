import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app1/firebaseUtils.dart';
import 'package:todo_app1/model/task.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = "en";
  ThemeMode appTheme = ThemeMode.light;

  void changeLanguage(String newLanguage) {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme) {
    if (appLanguage == newTheme) {
      return;
    }
    appTheme = newTheme;
    notifyListeners();
  }

  bool isDark() {
    return appTheme == ThemeMode.dark;
  }

  List<Task> tasksList = [];
  DateTime selectedDate = DateTime.now();
  void getAllTasksFromFireStore() async {
    QuerySnapshot<Task> querySnapshot =
        await FireBaseUtils.getTasksCollection().get();
    //return list of tasks
    tasksList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

   tasksList = tasksList.where((task) {
      if (selectedDate.day == task.dateTime?.day &&
          selectedDate.month == task.dateTime?.month &&
          selectedDate.year == task.dateTime?.year) {
        return true;
      }
      return false;
    }).toList();

    // tasksList
    //     .sort((task1, task2) => task1.dateTime!.compareTo(task2.dateTime!));
    notifyListeners();
  }

  void changeSelectedDate(DateTime newSelectedDate) {
    selectedDate = newSelectedDate;
    // refresh tasks list with filtering

    notifyListeners();
  }
}
