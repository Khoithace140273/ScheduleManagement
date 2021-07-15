import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Models/Note.dart';
import 'package:untitled/Models/SlidableNote.dart';
import 'package:untitled/NoteAndTask/addNote.dart';
import 'package:untitled/Data/ListNote.dart';
class NoteView extends StatefulWidget {
  const NoteView({Key? key}) : super(key: key);

  @override
  _NoteViewState createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  String noteContent = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
      "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. "
      "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. "
      "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  List <Note> items = List.of(NoteList.Notes);
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
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddNote()));
          },
        ),
        body: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: Expanded(
                child: ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return SlidableWidgetNote(child: buildListViewNote(item));
                  }
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListViewNote(Note item) => ListTile(
    title: Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 100,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 3,),
          Text(
            item.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2,),
          Text(
            item.content,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15,
              color: Color(0xff7c7c7c),
            ),
          ),
        ],
      ),
    ),
  );
}
