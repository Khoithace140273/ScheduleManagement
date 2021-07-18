import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:untitled/Data/ListTask.dart';
import 'package:untitled/Models/BuildOneTask.dart';
import 'SlidableTask.dart';
import 'Task.dart';
import 'package:intl/intl.dart';

class TaskListBuilder extends StatefulWidget {
  final List<Task> tasks;

  const TaskListBuilder({Key? key, required this.tasks}) : super(key: key);

  @override
  _TaskListBuilderState createState() => _TaskListBuilderState();
}

class _TaskListBuilderState extends State<TaskListBuilder> {
  final reminderController = new TextEditingController();

  bool _isFilled = false;

  ListTask _listTask = new ListTask();

  String dateTimePicker = "";

  String taskPop = "close";

  void _setDisableButton(int value) {
    if (value <= 0) {
      setState(() => _isFilled = false);
    } else {
      setState(() => _isFilled = true);
    }
  }

  String getNow() {
    DateTime now = new DateTime.now();
    String today = new DateFormat("dd/MM/yyyy").format(now);
    return today;
  }

  String getDateTimePicker(DateTime time) {
    String today = new DateFormat("dd/MM/yyyy hh:mm a").format(time);
    return today;
  }

  _showModalBottomSheetAddTask(context, Task taskData) {
    reminderController.text = taskData.titleTask;
    dateTimePicker = taskData.reminderTime;
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                  controller: reminderController,
                  decoration: InputDecoration(),
                  autofocus: true,
                  onChanged: (text) {
                    _setDisableButton(text.length);
                    print(text.length);
                  }),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Row(
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () {
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2015, 1, 1),
                          maxTime: DateTime(2030, 1, 1), onChanged: (date) {
                        print('change $date');
                      }, onConfirm: (date) {
                        dateTimePicker = getDateTimePicker(date);
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    icon: Icon(Icons.access_alarm),
                    label: Text("Set reminder"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      primary: Colors.white,
                      onPrimary: Color(0xFF5471F1),
                      side: BorderSide(color: Color(0xFF5471F1)),
                      shadowColor: Colors.transparent,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(child: Text(dateTimePicker)),
                  SizedBox(
                    width: 50,
                    child: TextButton(
                      child: Text(
                        "Done",
                        style: _isFilled
                            ? TextStyle(
                                color: Color(0xFF5471F1),
                              )
                            : TextStyle(
                                color: Color(0xFF7C7C7C),
                              ),
                      ),
                      onPressed: _isFilled
                          ? () {
                              taskData.titleTask = reminderController.text;
                              taskData.lastEditedTime = getNow();
                              taskData.reminderTime = dateTimePicker;
                              _listTask.updateTask(taskData);
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void deleteTask(context, Task taskData) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        _listTask.deleteTask(taskData);
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Task"),
      content: Text("Would you like to delete this task?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void onChangeStatus(Task taskData) {
    taskData.lastEditedTime = getNow();
    taskData.done = !(taskData.done);
    print(taskData.done);
    _listTask.updateTask(taskData);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: widget.tasks.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final item = widget.tasks[index];
          return SlidableWidgetTask(
              onTapUpdate: () {
                _showModalBottomSheetAddTask(context, item);
              },
              onTapDelete: () {
                deleteTask(context, item);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: Offset(0, 9),
                      blurRadius: 20,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: BuildOneTask(
                  item: item,
                  onChangeStatus: () {
                    onChangeStatus(item);
                  },
                ),
              ));
        });
  }
}
