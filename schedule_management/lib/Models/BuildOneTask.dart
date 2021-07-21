import 'package:flutter/material.dart';
import 'package:untitled/page/Models/Task.dart';

class BuildOneTask extends StatefulWidget {
  final Task item;
  final Function() onChangeStatus;
  const BuildOneTask(
      {Key? key, required this.item, required this.onChangeStatus})
      : super(key: key);

  @override
  _BuildOneTaskState createState() => _BuildOneTaskState();
}

class _BuildOneTaskState extends State<BuildOneTask> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: widget.item.done,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.item.titleTask,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: widget.item.done
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          ),
          Text(
            widget.item.reminderTime,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xff8c8c8c),
            ),
          ),
        ],
      ),
      onChanged: (value) {
        setState(() {
          widget.onChangeStatus();
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
