import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.chevron_left,
                  color: Theme.of(context).accentColor,
                  size: 35,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Your profile',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.edit,
                color: Theme.of(context).accentColor,
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
