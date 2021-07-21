import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/Models/NoteListBuilder.dart';
import 'package:untitled/page/Data/ListNote.dart';
import 'package:untitled/page/Models/Note.dart';
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
  String dateTimePicker = "";
  String taskPop = "close";
  ListNote _listNote= new ListNote();
  @override
  Widget build(BuildContext context) {
    return buildNotes();
  }

  @override
  void initState() {
    super.initState();
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
                    }),

              ),
              SizedBox(
                width: 50,
                child: TextButton(
                  child: Text(
                    "Done",
                    style: TextStyle(
                      color: Color(0xFF5471F1),
                    ),
                  ),
                  onPressed:() {
                    _listNote.addNote(getTextTitle, getTextContent,
                        getNow());
                    setState(() {
                      dateTimePicker = "";
                      tilteController.text = '';
                      contentController.text = '';
                      Navigator.of(context).pop();
                    });
                  }
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
