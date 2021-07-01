import 'package:flutter/material.dart';

final List<String> taskDescription = [];
final List<String> taskHeading = [];
TextEditingController taskHeadingController = new TextEditingController();
TextEditingController taskDescriptionController = new TextEditingController();
FocusNode textSecondFocusNode = new FocusNode();

int tasksHeaderMaxLenth = 25;
int tasksDescriptionMaxLines = 10;
int tasksDescriptionMaxLenth = 100;
String deletedTaskHeading = "";
String deletedTaskDescription = "";


// List<Color> taskColor = [
//   Colors.pink[50],
//   Colors.green[50],
//   Colors.blue[50],
//   Colors.orange[50],
//   Colors.indigo[50],
//   Colors.red[50],
//   Colors.yellow[50],
//   Colors.brown[50],
//   Colors.teal[50],
//   Colors.purple[50],
// ];
//
// List<Color> taskMarginColor = [
//   Colors.pink[300],
//   Colors.green[300],
//   Colors.blue[300],
//   Colors.orange[300],
//   Colors.indigo[300],
//   Colors.red[300],
//   Colors.yellow[300],
//   Colors.brown[300],
//   Colors.teal[300],
//   Colors.purple[300],
// ];