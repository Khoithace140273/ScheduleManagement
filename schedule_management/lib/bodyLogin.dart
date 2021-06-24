import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:untitled/LoginRegister/password.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Sign In",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              foreground: Paint()..color = Color.fromARGB(0xFF, 0x5B, 0x67, 0xCA),
            ),
          ),
        ),
          SizedBox(height: 40,),
          TextField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(borderSide: BorderSide(width: 2)),
              hintText: 'Username',
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)
            ),
          ),
          SizedBox(height: 15,),
          Password(),
          SizedBox(height: 15,),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 124),
              backgroundColor: Colors.deepPurpleAccent,
            ),
            onPressed: (){},
            child: Text(
              "Sign In",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 15,),
          Row(
            children: <Widget>[
              Expanded(
                  child: Divider(thickness: 2,)
              ),
              SizedBox(width: 5,),
              Text(
                "Or with",
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(width: 5,),
              Expanded(
                  child: Divider(thickness: 2,)
              ),
            ]
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                onPressed: (){},
                icon: Image.asset('asset/Button/fb1.png', height: 50, width: 50,),
                iconSize: 20,
              ),
              SizedBox(width: 10,),
              IconButton(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                onPressed: (){},
                icon: Image.asset('asset/Button/Google.png', height: 45, width: 45,),
                iconSize: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
