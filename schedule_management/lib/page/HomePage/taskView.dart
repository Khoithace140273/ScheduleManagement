import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:untitled/Models/TaskListBuilder.dart';
import 'package:untitled/page/Data/ListTask.dart';
import 'package:untitled/page/Models/Task.dart';

class TaskView extends StatefulWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final reminderController = new TextEditingController();
  final searchController = new TextEditingController();
  bool _isFilled = false;
  String dateTimePicker = "";
  String taskPop = "close";
  ListTask _listTask = new ListTask();
  late Future<List<Task>> tasksData;
  String get getTextReminder => reminderController.text;

  @override
  void initState() {
    super.initState();
    _isFilled = false;
    tasksData = _listTask.fetchTask();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> refreshList() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      tasksData = _listTask.fetchTask();
    });
  }

  void _setDisableButton(int value) {
    if (value <= 0) {
      setState(() => _isFilled = false);
    } else {
      setState(() => _isFilled = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshList,
      child: Stack(
        children: [
          Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                _showModalBottomSheetAddTask(context);
              },
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.topCenter,
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        leading: Icon(Icons.search),
                        title: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              hintText: 'Search', border: InputBorder.none),
                          onChanged: (value) {
                            setState(() {
                              refreshList();
                            });
                          },
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            searchController.clear();
                            setState(() {
                              refreshList();
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Today ${getNow()}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7C7C7C),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder<List<Task>>(
                          future: tasksData,
                          builder: (context, task) {
                            if (task.hasError) print(task.error);
                            return task.hasData
                                ? TaskListBuilder(
                              tasks: task.data!,
                              searchStr: searchController.text,
                            )
                                : Text("No Task");
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showModalBottomSheetAddTask(context) {
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
                                maxTime: DateTime(2030, 1, 1),
                                onChanged: (date) {
                              print('change $date');
                            }, onConfirm: (date) {
                              dateTimePicker = getDateTimePicker(date);
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          icon: Icon(Icons.access_alarm),
                          label: Text("Set reminder"),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
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
                                    _listTask.addTask(false, getTextReminder,
                                        dateTimePicker, dateTimePicker);
                                    setState(() {
                                      _isFilled = false;
                                      dateTimePicker = "";
                                      reminderController.text = '';
                                      Navigator.of(context).pop();
                                    });
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
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
}
