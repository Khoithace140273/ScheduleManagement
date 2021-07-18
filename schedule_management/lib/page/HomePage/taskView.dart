import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:untitled/page/Data/ListTask.dart';
import 'package:untitled/page/Models/SlidableTask.dart';
import 'package:untitled/page/Models/Task.dart';


class TaskView extends StatefulWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final reminderController = new TextEditingController();
  List <Task> items = List.of(ListTask.Tasks);
  bool _isFilled = false;
  String dateTimePicker = "";
  String taskPop = "close";
  @override
  void initState() {
    super.initState();
    _isFilled = false;
  }
  @override
  void dispose() {
    super.dispose();
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
    return Stack(
      children: [
        Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              _showModalBottomSheetAddTask(context);
            },
          ),
          body: Container(
            alignment: Alignment.topCenter,
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                    child: ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (context, index) => Divider(),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return SlidableWidgetTask(
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      offset: Offset(0,9),
                                      blurRadius: 20,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                              child: buildListViewTask(item)
                            )
                          );
                        }
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _showModalBottomSheetAddTask(context){
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal:20 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 8.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal:10 ),
                child: TextField(
                  controller: reminderController,
                  decoration: InputDecoration(
                  ),
                  autofocus: true,
                  onChanged: (text) {
                    _setDisableButton(text.length);
                    print(text.length);
                  }
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Row(
                  children: <Widget>[
                    ElevatedButton.icon(
                      onPressed: (){
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
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        primary: Colors.white,
                        onPrimary: Color(0xFF5471F1),
                        side: BorderSide(color: Color(0xFF5471F1)),
                        shadowColor: Colors.transparent,
                      ),
                    ),
                    SizedBox(width: 5,),
                    Expanded(child: Text(dateTimePicker)),
                    SizedBox(
                      width: 50,
                      child: TextButton(
                        child: Text(
                          "Done",
                          style: _isFilled? TextStyle(
                            color: Color(0xFF5471F1),
                          ) :
                          TextStyle(
                              color: Color(0xFF7C7C7C),
                          ),
                        ),
                        onPressed: _isFilled ? (){}: null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildListViewTask(Task item) => CheckboxListTile(
    value: item.done,
    title: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          item.titleTask,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            decoration: item.done? TextDecoration.lineThrough : TextDecoration.none
          ),
        ),
        Text(
          item.reminderTime,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xff8c8c8c),
          ),
        ),
      ],
    ),
    onChanged: (value) {
      setState(() {
        item.done = !item.done;
      });
    },
    controlAffinity: ListTileControlAffinity.leading,
  );

  openTaskPop(){
    taskPop = "open";
    setState(() {

    });
  }

  closeTaskPop(){
    taskPop = "close";
    setState(() {

    });
  }

  String getNow(){
    DateTime now = new DateTime.now();
    String today = new DateFormat("dd/MM/yyyy").format(now);
    return today;
  }

  String getDateTimePicker(DateTime time){
    String today = new DateFormat("dd/MM/yyyy hh:mm a").format(time);
    return today;
  }
}

