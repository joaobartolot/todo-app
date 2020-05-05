import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/widget/profile_app_bar.dart';
import 'package:todo_firebase/widget/profile_photo.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ProfileAppBar(),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: StreamBuilder<FirebaseUser>(
                    stream: FirebaseAuth.instance.currentUser().asStream(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                        );
                      return Container(
                        child: Flex(
                          direction: Axis.vertical,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 50.0,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 125.0,
                                      height: 125.0,
                                      child: Stack(
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.center,
                                            child: ProfilePhoto(
                                              name: snapshot.data.displayName,
                                              photoUrl: snapshot.data.photoUrl,
                                              radio: 100.0,
                                            ),
                                          ),
                                          Positioned(
                                            right: 0.0,
                                            bottom: 0.0,
                                            child: IconButton(
                                              icon: Icon(Icons.camera_enhance),
                                              color:
                                                  Theme.of(context).accentColor,
                                              onPressed: () => print('object'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 50.0),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Name:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Theme.of(context).disabledColor,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      Text(
                                        snapshot.data.displayName,
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 25.0),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Email:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Theme.of(context).disabledColor,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      Text(
                                        snapshot.data.email,
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    'Delete account',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    'Signout',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                                SizedBox(height: 30.0)
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
