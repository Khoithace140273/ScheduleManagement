import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/db/user_database.dart';
import 'package:untitled/model/user.dart';
import 'package:untitled/page/HomePage/homePage.dart';
import 'package:untitled/page/components/rounded_button.dart';
import 'package:http/http.dart' as http;

class ChangePasswordBody extends StatefulWidget {
  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordBody> {
  bool _isObscure = true;
  String password = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final TextEditingController newPasswordConfirmController =
      new TextEditingController();
  final TextEditingController newPasswordController =
      new TextEditingController();
  final TextEditingController oldPasswordController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(

        //drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('Change Password'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Change Password',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                SizedBox(height: size.height * 0.03),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextFormField(
                    controller: oldPasswordController,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      hintText: 'Enter your old password',
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
                    controller: newPasswordController,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      hintText: 'Enter your new password',
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
                    controller: newPasswordConfirmController,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      hintText: 'Enter your confirm password',
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
                      } else if (newPasswordController.text != newPasswordConfirmController.text) {
                        return "Password does not match";
                      }
                      else
                      return null;
                    },
                    onSaved: (val) {
                      password = val!;
                    },
                  ),
                  //Text Button
                ),
                RoundedButton(
                  text: "Change Password",
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      ChangePassword(oldPasswordController.text,
                          newPasswordController.text);
                    }
                  },
                )
              ],
            )));
  }

  ChangePassword(String oldpass, newpass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<User> user =  await UserDatabase.instance.getUser();
    if (oldpass.isNotEmpty && newpass.isNotEmpty) {
      Map data = {"OldPassword": oldpass, "NewPassword": newpass};
      var jsonResponse = null;
      var response = await http.post(
          Uri.parse("http://14.237.119.17:8080/api/userpass"),
          body: data);

      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        if (jsonResponse == true) {
          setState(() {
            _isLoading = false;
          });
          oldPasswordController.clear();
          newPasswordController.clear();
          newPasswordConfirmController.clear();
          _displaySuccessToast(context);
          Timer(Duration(seconds: 3), () {
            // 5 seconds over, navigate to Page2.
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => HomePage()));
          });
        } else {
          _displayErrorToast(context);
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        print(response.body);
      }
    }
  }

  void _displaySuccessToast(context) {
    MotionToast.success(
            title: "Success",
            titleStyle: TextStyle(fontWeight: FontWeight.bold),
            description: "Sign Up Successful",
            animationType: ANIMATION.FROM_RIGHT,
            width: 500,
            toastDuration: const Duration(seconds: 2))
        .show(context);
  }

  void _displayErrorToast(context) {
    MotionToast.error(
            title: "Error",
            titleStyle: TextStyle(fontWeight: FontWeight.bold),
            description: "Username already exists",
            width: 500,
            animationType: ANIMATION.FROM_RIGHT,
            toastDuration: const Duration(seconds: 2))
        .show(context);
  }
}
