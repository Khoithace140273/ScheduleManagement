import 'package:flutter/cupertino.dart';

class Task with ChangeNotifier {
  String id;
  bool done;
  String titleTask;
  String reminderTime;
  String lastEditedTime;

  Task empty() {
    return new Task('', false, '', '', '');
  }

  Task(this.id, this.done, this.titleTask, this.reminderTime,
      this.lastEditedTime);

  factory Task.fromJson(Map<String, dynamic> json) {
    print(json['done']);
    return Task(json['id'], json['done'], json['titleTask'],
        json['reminderTime'], json['lastEditedTime']);
  }
}
