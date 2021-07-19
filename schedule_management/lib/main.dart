import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/constants.dart';
import 'package:untitled/db/user_database.dart';
import 'package:untitled/page/HomePage/homePage.dart';
import 'package:untitled/page/Welcome/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
 String lastResult = "";
  @override
  Widget build(BuildContext context) {
     check();

    return MaterialApp(
      title: '',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: _decideMainPage(),
    );
  }

  _decideMainPage() {
      debugPrint("Result: "+ lastResult);
      if (lastResult.compareTo("0") != 0) {
      return HomePage();
    } else {
      return WelcomeScreen();
    }
  }

 Future<void> check() async {
   final result = await UserDatabase.instance.CheckExist();
   lastResult = result;
  }
}
