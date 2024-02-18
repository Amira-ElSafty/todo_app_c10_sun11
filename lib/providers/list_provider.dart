import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_todo_c10_sun11/firebase_utils.dart';
import 'package:flutter_app_todo_c10_sun11/model/task.dart';

class ListProvider extends ChangeNotifier {
  // data
  List<Task> tasksList = [];
  DateTime selectedDate = DateTime.now();

  void getAllTasksFromFireStore() async {
    /// get all tasks
    QuerySnapshot<Task> querySnapshot =
        await FirebaseUtils.getTasksCollection().get();

    /// List<QueryDocumentSnapshot<Task>>   => List<Task>
    tasksList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    /// filter tasks
    /// selected date
    tasksList = tasksList.where((task) {
      if (selectedDate.day == task.dateTime!.day &&
          selectedDate.month == task.dateTime!.month &&
          selectedDate.year == task.dateTime!.year) {
        return true;
      }
      return false;
    }).toList();

    /// sorting tasks
    tasksList.sort((task1, task2) {
      return task1.dateTime!.compareTo(task2.dateTime!);
    });

    notifyListeners();
  }

  void changeSelectedDate(DateTime newSelectedDate) {
    selectedDate = newSelectedDate;
    getAllTasksFromFireStore();
  }
}
