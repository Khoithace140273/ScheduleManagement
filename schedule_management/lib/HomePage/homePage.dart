import 'package:flutter/material.dart';
import 'package:untitled/HomePage/taskView.dart';
import 'package:untitled/NoteAndTask/addNote.dart';
import 'package:untitled/HomePage/noteView.dart';
import '/Drawer/navMenu.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF5471F1),
          elevation: 0,
          bottom: const TabBar(
            labelColor: Color(0xFF5471F1),
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              color: Colors.white,
            ),
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
                    child: Align(
                        alignment: Alignment.center,
                        child: Text('Setting')),
                ),
              ],
            ),
          ],
        ),
        drawer: NavMenu(),
        body: TabBarView(
            children: <Widget>[
              Center(child: NoteView()),
              Center(child: TaskView()),
            ],
        ),
      ),
    );
  }
}
