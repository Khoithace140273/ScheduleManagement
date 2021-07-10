import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AddNote extends StatelessWidget {

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){}, child: Text('Save')),
          PopupMenuButton<int>(
            itemBuilder: (context) =>[
              PopupMenuItem(
                child: Text('Delete'),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(),
              child: TextField(
                controller: title,
                decoration: InputDecoration(hintText: 'Title'),
              ),
            ),
            Expanded(
                child: Container(
                  decoration: BoxDecoration(),
                  child: TextField(
                    controller: content,
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(hintText: 'Start typing'),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
