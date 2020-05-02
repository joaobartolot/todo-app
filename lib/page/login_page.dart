import 'package:dartz/dartz.dart' as dartz;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/provider/login_provider.dart';
import 'package:todo_firebase/util/failure.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FocusNode _focusEmail = FocusNode();
    final FocusNode _focusPassword = FocusNode();

    return Padding(
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
                  child: Image(image: AssetImage('assets/to_do.png')),
                ),
                SizedBox(height: 40.0),
                ChangeNotifierProvider<LoginProvider>(
                  create: (context) => LoginProvider(),
                  child: LoginForm(
                    focusPassword: _focusPassword,
                    focusEmail: _focusEmail,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
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
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<LoginProvider>(context);

    return Form(
      child: Column(
        children: <Widget>[
          TextField(
            controller: _email,
            obscureText: false,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) =>
                FocusScope.of(context).requestFocus(widget._focusPassword),
            focusNode: widget._focusEmail,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              prefixIcon: Icon(Icons.alternate_email),
              hasFloatingPlaceholder: true,
              labelText: 'Email',
            ),
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: _password,
            obscureText: true,
            onSubmitted: (_) => FocusScope.of(context).unfocus(),
            focusNode: widget._focusPassword,
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // Row(
              //   children: <Widget>[
              //     Checkbox(
              //       value: state.rememberMe,
              //       onChanged: (value) {
              //         state.rememberMe = value;
              //       },
              //       activeColor: Theme.of(context).primaryColor,
              //     ),
              //     GestureDetector(
              //       child: Text('Remember-me'),
              //       onTap: () => state.rememberMe = !state.rememberMe,
              //     )
              //   ],
              // ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());

                  if (_email.text.length == 0) {
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text('Oops 😯'),
                        content: Text("You forgot to enter your email."),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('Ok'),
                          ),
                        ],
                      ),
                    );
                    return;
                  } else if (_password.text.length == 0) {
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text('Oops 😯'),
                        content: Text("You forgot to enter your password."),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('Ok'),
                          ),
                        ],
                      ),
                    );
                    return;
                  }

                  dartz.Either<Failure, FirebaseUser> result =
                      await state.authenticateUser(_email.text, _password.text);
                  result.fold(
                    (error) => showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text('Error 😯'),
                        content: Text(error.mensage),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('Ok'),
                          ),
                        ],
                      ),
                    ),
                    (success) =>
                        Navigator.pushReplacementNamed(context, '/home'),
                  );
                },
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
