import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FocusNode _focusEmail = FocusNode();
    final FocusNode _focusPassword = FocusNode();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 40.0),
            child: Center(
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height: 250,
                        child: SvgPicture.asset('assets/to_do.svg'),
                      ),
                      SizedBox(height: 40.0),
                      LoginForm(
                          focusPassword: _focusPassword,
                          focusEmail: _focusEmail),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key key,
    @required FocusNode focusPassword,
    @required FocusNode focusEmail,
  })  : _focusPassword = focusPassword,
        _focusEmail = focusEmail,
        super(key: key);

  final FocusNode _focusPassword;
  final FocusNode _focusEmail;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          TextField(
            obscureText: false,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_focusPassword),
            focusNode: _focusEmail,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              prefixIcon: Icon(Icons.email),
              hasFloatingPlaceholder: true,
              labelText: 'Email',
            ),
          ),
          SizedBox(height: 20.0),
          TextField(
            obscureText: true,
            onSubmitted: (_) => FocusScope.of(context).unfocus(),
            focusNode: _focusPassword,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              prefixIcon: Icon(Icons.lock),
              hasFloatingPlaceholder: true,
              labelText: 'Password',
            ),
          ),
          SizedBox(height: 10.0),
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Radio(
                    value: null,
                    groupValue: null,
                    onChanged: (value) => print('implement'),
                    activeColor: Theme.of(context).primaryColor,
                  ),
                  Text('Remember-me')
                ],
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
                onPressed: () =>
                    FocusScope.of(context).requestFocus(FocusNode()),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
