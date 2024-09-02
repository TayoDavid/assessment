import 'package:assessment/ui/add_task.dart';
import 'package:assessment/ui/home.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomeScreen.route: (context) => HomeScreen(),
  AddTaskScreen.route: (context) => AddTaskScreen(),
};
