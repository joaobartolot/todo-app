import 'package:flutter/material.dart';
import 'package:todo_firebase/page/login_page.dart';
import 'package:todo_firebase/page/sign_up_page.dart';

class LoginSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pageController = PageController(initialPage: 0);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Expanded(child: LoginPage()),
                  GestureDetector(
                    onTap: () => _pageController.animateToPage(
                      1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOutCubic,
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Theme.of(context).accentColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
              Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () => _pageController.animateToPage(
                      0,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOutCubic,
                    ),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.keyboard_arrow_up,
                          color: Theme.of(context).accentColor,
                        ),
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: SignUpPage()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
