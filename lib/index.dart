import 'package:flutter/material.dart';
import 'package:todo_firebase/helper/user_helper.dart';

class Index extends StatefulWidget {
  Index({Key key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  void initState() {
    super.initState();

    UserHelper.userIsLogged().then(
      (isLogged) {
        if (isLogged) {
          Navigator.pushReplacementNamed(context, '/home');
        } else
          Navigator.pushReplacementNamed(context, '/login');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
