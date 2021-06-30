import 'package:flutter/material.dart';
import 'package:untitled/NoteAndTask/addNote.dart';
import 'package:untitled/HomePage/noteView.dart';
import '/Drawer/navMenu.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) =>[
              PopupMenuItem(
                  child: Text('Setting'),
              ),
            ],
          ),
        ],
      ),
      drawer: NavMenu(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>AddNote()));
        },
      ),
      body: NoteView(),
    );
  }
}
