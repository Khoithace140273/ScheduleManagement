import 'package:flutter/material.dart';
import 'package:untitled/NoteAndTask/addNote.dart';
import 'package:untitled/HomePage/noteView.dart';
import '/Drawer/navMenu.dart';
import 'package:untitled/schedule.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const TabBar(
            indicatorColor: Colors.transparent,
            tabs: <Widget>[
              Tab(
                child: Text('Notes', style: TextStyle(fontSize: 20),),
              ),
              Tab(
                child: Text('Tasks', style: TextStyle(fontSize: 20),),
              ),
            ]
          ),
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
        body: TabBarView(
            children: <Widget>[
              Center(child: NoteView()),
              Center(),
            ],
        ),
      ),
    );
  }
}
