import 'package:flutter/material.dart';

class Password extends StatefulWidget {

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> with SingleTickerProviderStateMixin {

  bool showPass = true;
  late FocusNode passFocusNode;
  @override
  void initState() {
    super.initState();
    passFocusNode = FocusNode();
  }

  @override
  void dispose() {
    passFocusNode.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: passFocusNode,
      onTap: (){
        setState(() {
          FocusScope.of(context).unfocus();
          FocusScope.of(context).requestFocus(passFocusNode);
        });
      },
      obscureText: showPass,
      decoration: InputDecoration(
        border: UnderlineInputBorder(borderSide: BorderSide(width: 2)),
        hintText: 'Password',
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        suffixIcon: GestureDetector(
          onTap: () => setState((){
            showPass = !showPass;
          }),
          child: Icon(
              showPass ? Icons.visibility_off : Icons.visibility
          ),
        ),
      ),
    );
  }
}
class PasswordConfirm extends StatefulWidget {

  @override
  _PasswordConfirmState createState() => _PasswordConfirmState();
}

class _PasswordConfirmState extends State<PasswordConfirm> with SingleTickerProviderStateMixin {

  bool showPass = true;
  late FocusNode passFocusNode;
  @override
  void initState() {
    super.initState();
    passFocusNode = FocusNode();
  }

  @override
  void dispose() {
    passFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: passFocusNode,
      onTap: (){
        setState(() {
          FocusScope.of(context).unfocus();
          FocusScope.of(context).requestFocus(passFocusNode);
        });
      },
      obscureText: showPass,
      decoration: InputDecoration(
        border: UnderlineInputBorder(borderSide: BorderSide(width: 2)),
        hintText: 'Confirm Password',
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        suffixIcon: GestureDetector(
          onTap: () => setState((){
            showPass = !showPass;
          }),
          child: Icon(
              showPass ? Icons.visibility_off : Icons.visibility
          ),
        ),
      ),
    );
  }
}

