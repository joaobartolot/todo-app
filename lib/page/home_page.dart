import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_firebase/helper/user_helper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 60.0,
                  color: Colors.grey[100],
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(FontAwesomeIcons.signOutAlt),
                        onPressed: () {
                          UserHelper.setUserUid('');
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
