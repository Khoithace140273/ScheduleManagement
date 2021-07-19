import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/Models/Note.dart';
import 'package:untitled/Models/NoteListBuilder.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:untitled/Models/SlidableNote.dart';
import 'package:untitled/Note/addNote.dart';
import 'package:untitled/Data/ListNote.dart';
class NoteView extends StatefulWidget {
  const NoteView({Key? key}) : super(key: key);

  @override
  _NoteViewState createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  final tilteController = new TextEditingController();
  final contentController = new TextEditingController();
  String get getTextContent => contentController.text;
  String get getTextTitle => tilteController.text;
  bool _isFilled = false;
  String dateTimePicker = "";
  String taskPop = "close";
  ListNote _listNote= new ListNote();
  @override
  Widget build(BuildContext context) {
    _isFilled = false;
    return buildNotes();
  }
  void _setDisableButton(int value) {
    if (value <= 0) {
      setState(() => _isFilled = false);
    } else {
      setState(() => _isFilled = true);
    }
  }
  @override
  void initState() {
    super.initState();
    _isFilled = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildNotes() {
    return Container(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
                _showModalBottomSheetAddNote(context);
          },
        ),
        body: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: Expanded(
                child: FutureBuilder<List<Note>>(
                    future: _listNote.fetchNote(),
                    builder: (context, note) {
                      if (note.hasError) print(note.error);
                      return note.hasData
                      ? NoteListBuilder(notes: note.data!)
                          : Text("No Task");

                  }
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
  _showModalBottomSheetAddNote(context){
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
                    _listNote.addNote(getTextTitle, getTextContent,
                        getNow());
                    setState(() {
                      _isFilled = true;
                      dateTimePicker = "";
                      tilteController.text = '';
                      contentController.text = '';
                      Navigator.of(context).pop();
                    });
                  }
                      : null,
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
}
