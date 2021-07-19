import 'dart:math';
import 'package:flutter/material.dart';
import 'package:untitled/main.dart';
import 'package:untitled/page/NavMenu/Page/ChangePassword/changePassword.dart';

class NavMenuBody extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final name = 'Sarah Abs';
    return Drawer(
      child: Material(
        color: Color.fromARGB(0xFF, 0x5B, 0x67, 0xCA),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            buildHeader(
              urlImage: randomImg(),
              name: name,
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.05),
                  buildMenuItem(
                    text: 'Change password',
                    icon: Icons.password,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Divider(color: Colors.white70),
                  SizedBox(height: size.height * 0.05),
                  buildMenuItem(
                    text: 'Logout',
                    icon: Icons.logout,
                    onClicked: () => selectedItem(context, 1),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.445),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      'v1.0',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 20,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
  }) =>
      InkWell(
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: AssetImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp()));
        break;
    }
  }

  String randomImg() {
    var listImagesnotFound = [
      "assets/avatarImg/avatar1.png",
      "assets/avatarImg/avatar2.png",
      "assets/avatarImg/avatar3.png",
      "assets/avatarImg/avatar4.png",
      "assets/avatarImg/avatar5.png",
      "assets/avatarImg/avatar6.png"
    ];
    var _random = Random();
    String imageToShow =
        listImagesnotFound[_random.nextInt(listImagesnotFound.length)];
    debugPrint('imageToShow: ' + imageToShow);
    return imageToShow;
  }
}
