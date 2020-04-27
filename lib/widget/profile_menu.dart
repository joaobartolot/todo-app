import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_firebase/helper/user_helper.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 30.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Text(
                    'Megan Maddison',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text('meganmaddison@gmail.com'),
                ],
              ),
            ),
            SizedBox(height: 25.0),
            GestureDetector(
              onTap: () => print('implement'),
              child: Row(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.addressCard,
                    color: Theme.of(context).accentColor,
                    size: 18.0,
                  ),
                  SizedBox(width: 15.0),
                  Text('Profile'),
                ],
              ),
            ),
            SizedBox(height: 15.0),
            GestureDetector(
              onTap: () {
                UserHelper.setUserUid('');
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Row(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.signOutAlt,
                    color: Theme.of(context).accentColor,
                    size: 18.0,
                  ),
                  SizedBox(width: 15.0),
                  Text('Logout'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
