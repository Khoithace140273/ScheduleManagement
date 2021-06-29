import 'package:flutter/material.dart';

class NoteView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: 10,
        itemBuilder: (_, index){
          return Container(
            margin: EdgeInsets.all(10),
            height: 150,
            color: Colors.grey[200],
          );
      }),
    );
  }
}
