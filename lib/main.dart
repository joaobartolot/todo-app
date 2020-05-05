import 'package:flutter/material.dart';
import 'package:todo_firebase/index.dart';
import 'package:todo_firebase/page/home_page.dart';
import 'package:todo_firebase/page/login_page.dart';
import 'package:todo_firebase/page/login_signup_page.dart';
import 'package:todo_firebase/page/profile_page.dart';
import 'package:todo_firebase/page/sign_up_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff4C78FF),
        accentColor: Color(0xff37487C),
        fontFamily: '.SF Pro Display',
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Color(0xff37487C),
              displayColor: Color(0xff37487C),
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Index(),
        '/login-signup': (context) => LoginSignUpPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
