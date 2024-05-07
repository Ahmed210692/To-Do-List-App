import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_app/task_model.dart';

class Taskviwemodel extends ChangeNotifier {
  List<Task> tasks = [];

  String? taskName;
  final dateCont = TextEditingController();
  final timeCont = TextEditingController();

  DateTime? _date;
  TimeOfDay? _time; // Added property to store time

  bool get isValid =>
      taskName != null && dateCont.text == "" && timeCont.text == "";

  setTaskName(String value) {
    taskName = value;
    notifyListeners();
  }

  setDate(DateTime? date) {
    if(date == null){
      return;
    }

    DateTime currentDate = DateTime.now();
    DateTime now = DateTime(currentDate.year, currentDate.month, currentDate.day);
    int diff = date.difference(now).inDays;
    if(diff == 0){
      dateCont.text = "Today";
    }
    else if ( diff == 1){
      dateCont.text = "Tomorrow";
    }

    else {
      dateCont.text =" ${date.day}-${date.month}-${date.year}";
    }
    notifyListeners();
}

  setTime(TimeOfDay? time) {
    if(time == null){
      return;
    }

    else if(time.hour == 0){
      timeCont.text = "12: ${time.minute} AM";
    }

    else if(time.hour < 12 ){
      timeCont.text = "${time.hour}:${time.minute} AM";
    }

    else if(time.hashCode == 12){
      timeCont.text = "${time.hour}:${time.minute} PM";
    }

    else {
      timeCont.text = "${time.hour - 12}:${time.minute} AM";
    }
    notifyListeners(); // Notify listeners about the change in time
  }

  addTask() {
    //if (!isValid) {
    //  return;
   // }
    final task = Task(dateCont.text, taskName!, timeCont.text); // Modify constructor if needed
    tasks.add(task);
    dateCont.clear();
    timeCont.clear();
    notifyListeners();
  }
}
