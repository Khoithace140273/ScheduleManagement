import 'dart:ui';

import 'package:flutter/material.dart';

class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Welcome to Schedule Management",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 15,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: TextField(

              decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide(width: 2)),
              hintText: 'Username',
              contentPadding: EdgeInsets.all(20)
              ),

            ),
          ),
          SizedBox(height: 15,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(width: 2)),
                hintText: 'Password',
                contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20)
              ),
            ),
          ),
          SizedBox(height: 15,),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              backgroundColor: Colors.deepPurpleAccent,
            ),
            onPressed: (){},
            child: Text(
              "LOGIN",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(

                onPressed: (){},
                icon: Image.asset('asset/Button/fb.png', height: 200, width: 200,),
                iconSize: 60,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
