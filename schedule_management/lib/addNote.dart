import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AddNote extends StatelessWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){}, child: Text('Save'))
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(),
              child: TextField(
                decoration: InputDecoration(hintText: 'Title'),
              ),
            ),

            Expanded(
                child: Container(
                  decoration: BoxDecoration(),
                  child: TextField(
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
