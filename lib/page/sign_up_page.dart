import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/provider/sign_up_provider.dart';
import 'package:todo_firebase/util/failure.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpProvider(),
      child: Container(
        child: SignUpForm(),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _email = TextEditingController();
    final TextEditingController _password = TextEditingController();
    final FocusNode _focusEmail = FocusNode();
    final FocusNode _focusPassword = FocusNode();

    final provider = Provider.of<SignUpProvider>(context);

    return Form(
      child: Column(
        children: <Widget>[
          TextField(
            controller: _email,
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
                  // Either<Failure, FirebaseUser> result = await provider
                  //     .createuser(_email.text, _password.text, '');
                  // result.fold(
                  //   (error) => showDialog(
                  //     context: context,
                  //     child: AlertDialog(
                  //       title: Text('Error 😯'),
                  //       content: Text(error.mensage),
                  //       actions: <Widget>[
                  //         FlatButton(
                  //           onPressed: () => Navigator.of(context).pop(),
                  //           child: Text('Ok'),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   (success) =>
                  //       Navigator.pushReplacementNamed(context, '/home'),
                  // );
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
