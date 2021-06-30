import 'package:flutter/material.dart';

class NavMenu extends StatelessWidget {
  const NavMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(0xFF, 0x5B, 0x67, 0xCA)),
            child: Text(
              'Hello',
            ),
          ),
        ],
      ),
    );
  }
}
