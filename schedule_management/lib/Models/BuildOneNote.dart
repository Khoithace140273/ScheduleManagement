import 'package:flutter/material.dart';
import 'package:untitled/page/Models/Note.dart';

class BuildOneNote extends StatefulWidget {
  final Note item;
  final Function() onChangeStatus;
  const BuildOneNote(
      {Key? key, required this.item, required this.onChangeStatus})
      : super(key: key);

  @override
  _BuildOneNoteState createState() => _BuildOneNoteState();
}

class _BuildOneNoteState extends State<BuildOneNote> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.item.titleNote,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            widget.item.content,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xff8c8c8c),
            ),
          ),
        ],
      ),

    );
  }
}
