import 'package:flutter/material.dart';
import 'package:untitled/Data/ListTask.dart';
import 'package:untitled/Models/BuildOneTask.dart';
import 'SlidableTask.dart';
import 'Task.dart';

class TaskListBuilder extends StatelessWidget {
  final List<Task> tasks;
  const TaskListBuilder({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: tasks.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final item = tasks[index];
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
                  offset: Offset(0, 9),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: BuildOneTask(
              item: item,
            ),
          ));
        });
  }
}
