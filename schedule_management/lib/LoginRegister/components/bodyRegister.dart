import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:untitled/HomePage/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http ;
import 'package:motion_toast/motion_toast.dart';
import 'InputDeco_design.dart';

class BodyR extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<BodyR> {
  final TextEditingController passwordConfirmController =
  new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController usernameController = new TextEditingController();

  bool _isObscure = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username = "", password = "";

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        foreground: Paint()
                          ..color = Color.fromARGB(0xFF, 0x5B, 0x67, 0xCA),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    controller: usernameController,
                    decoration: buildInputDecoration(Icons.person, 'Username'),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please enter your Username';
                      }else if(val!.length<6){
                        return 'Username contain at least 6 characters in length';
                      }
                      else
                        return null;
                    },
                    onSaved: (val) {
                      username = val!;
                    },
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.green, width: 1.5),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 1.5,
                        ),
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please enter your Password';
                      } else if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(val)) {
                        return 'Password contain at least 1 Upper case';
                      } else if (!RegExp(r'^(?=.*[a-z])').hasMatch(val)) {
                        return 'Password contain at least 1 Lower case';
                      } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(val)) {
                        return 'Password contain at least 1 digit';
                      } else if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(val)) {
                        return 'Password contain at least 1 Special character';
                      } else if (!RegExp(r'^.{8,}').hasMatch(val)) {
                        return 'Password contain at least 8 characters in length';
                      } else
                        return null;
                    },
                    onSaved: (val) {
                      password = val!;
                    },
                  ),
                  //Text Button
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    controller: passwordConfirmController,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.green, width: 1.5),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 1.5,
                        ),
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please enter your Password';
                      } else if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(val)) {
                        return 'Password contain at least 1 Upper case';
                      } else if (!RegExp(r'^(?=.*[a-z])').hasMatch(val)) {
                        return 'Password contain at least 1 Lower case';
                      } else if (!RegExp(r'^(?=.*?[0-9])').hasMatch(val)) {
                        return 'Password contain at least 1 digit';
                      } else if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(val)) {
                        return 'Password contain at least 1 Special character';
                      } else if (!RegExp(r'^.{8,}').hasMatch(val)) {
                        return 'Password contain at least 8 characters in length';
                      } else if (passwordController.text !=
                          passwordConfirmController.text) {
                        return "Password does not match";
                      } else
                        return null;
                    },
                  ),
                ),
                //Text Button
                ElevatedButton(
                  style: TextButton.styleFrom(
                    padding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 121),
                    backgroundColor: Colors.deepPurpleAccent,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
                      setState(() {
                        _isLoading = true;
                      });
                      signUp(usernameController.text, passwordController.text);
                    }
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(children: <Widget>[
                  Expanded(
                      child: Divider(
                        thickness: 2,
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Or with",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Divider(
                        thickness: 2,
                      )),
                ]),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/Button/fb1.png',
                        height: 50,
                        width: 50,
                      ),
                      iconSize: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/Button/Google.png',
                        height: 45,
                        width: 45,
                      ),
                      iconSize: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  signUp(String username, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(username.isNotEmpty && pass.isNotEmpty){
      Map data = {
        "Username": username,
        "Password": pass,
        "Uidfacebook" : "",
        "Uidgoogle": ""
      };
      var jsonResponse = null;
      var response = await http.post(Uri.parse("http://113.187.112.168:8080/api/user"), body: data);

      if(response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        if(jsonResponse == true) {
          setState(() {
            _isLoading = false;
          });
          usernameController.clear();
          passwordController.clear();
          passwordConfirmController.clear();
          _displaySuccessToast(context);
          Timer(Duration(seconds: 3), () {
            // 5 seconds over, navigate to Page2.
            Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
          });
/*
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomePage()), (Route<dynamic> route) => false);
*/
        }
        else {
          _displayErrorToast(context);
        }
      }
      else {
        setState(() {
          _isLoading = false;
        });
        print(response.body);
      }
    }
  }
  void _displaySuccessToast(context){
    MotionToast.success(
        title: "Success",
        titleStyle: TextStyle(fontWeight: FontWeight.bold),
        description: "Sign Up Successful",
        animationType:  ANIMATION.FROM_RIGHT,
        width:  500,
        toastDuration: const Duration (seconds : 2)
    ).show(context);
  }
  void _displayErrorToast(context){
    MotionToast.error(
        title: "Error",
        titleStyle: TextStyle(fontWeight: FontWeight.bold),
        description: "Username already exists",
        width:  500,
        animationType:  ANIMATION.FROM_RIGHT,
        toastDuration: const Duration (seconds : 2)
    ).show(context);
  }
}
