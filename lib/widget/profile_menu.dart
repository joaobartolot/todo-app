import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileMenu extends StatelessWidget {
  final String name;
  final String email;
  const ProfileMenu({
    Key key,
    this.name,
    this.email,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(email),
                ],
              ),
            ),
            SizedBox(height: 25.0),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/profile'),
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
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login-signup');
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
