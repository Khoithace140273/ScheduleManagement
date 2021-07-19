import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:untitled/Data/ListNote.dart';
import 'package:untitled/Models/BuildOneNote.dart';
import 'SlidableNote.dart';
import 'Note.dart';
import 'package:intl/intl.dart';

class NoteListBuilder extends StatefulWidget {
  final List<Note> notes;

  const NoteListBuilder({Key? key, required this.notes}) : super(key: key);

  @override
  _NoteListBuilderState createState() => _NoteListBuilderState();
}

class _NoteListBuilderState extends State<NoteListBuilder> {
  final tilteController = new TextEditingController();
  final contentController = new TextEditingController();
  bool _isFilled = false;

  ListNote _listNote = new ListNote();

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

  void deleteNote(context, Note taskData) {
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
        _listNote.deleteNote(taskData);
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

  void onChangeStatus(Note NoteData) {
    NoteData.lastEditedTime = getNow();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: widget.notes.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final item = widget.notes[index];
          return SlidableWidgetNote(
              onTapUpdate: () {
                _showModalBottomSheetAddNote(context, item);
              },
              onTapDelete: () {
                deleteNote(context, item);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                height: 80,
                child: BuildOneNote(
                  item: item,
                  onChangeStatus: () {
                    onChangeStatus(item);
                  },
                ),
              ));
        });
  }
  _showModalBottomSheetAddNote(context, Note NoteData){
    tilteController.text=NoteData.titleNote;
    contentController.text=NoteData.content;
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 100),
                child: TextField(
                    controller: tilteController,
                    decoration: InputDecoration(),
                    autofocus: true,
                    onChanged: (text) {
                      print(text.length);
                    }),

              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 100),
                child: TextField(
                    controller: contentController,
                    decoration: InputDecoration(),
                    autofocus: true,
                    onChanged: (text) {
                      _setDisableButton(text.length);
                      print(text.length);
                    }),

              ),
              SizedBox(
                width: 50,
                child: TextButton(
                  child: Text(
                    "Done",
                    style: true
                        ? TextStyle(
                      color: Color(0xFF5471F1),
                    )
                        : TextStyle(
                      color: Color(0xFF7C7C7C),
                    ),
                  ),
                  onPressed: true
                      ? () {
                    NoteData.titleNote = tilteController.text;
                    NoteData.content = contentController.text;
                    NoteData.lastEditedTime = getNow();
                    _listNote.updateNote(NoteData);
                  }
                  : null,
                ),
              ),

            ],
          ),
        ));
  }
}
