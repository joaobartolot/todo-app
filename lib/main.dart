import 'package:flutter/material.dart';
import 'package:todo_firebase/index.dart';
import 'package:todo_firebase/page/home_page.dart';
import 'package:todo_firebase/page/login_page.dart';

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
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Index(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
