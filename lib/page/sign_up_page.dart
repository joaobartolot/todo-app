import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Container(
              height: 250,
              child: Image(image: AssetImage('assets/to_do_signup.png')),
            ),
            SizedBox(height: 25.0),
            SignUpForm(),
          ],
        ),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _name = TextEditingController();
    final TextEditingController _email = TextEditingController();
    final TextEditingController _password = TextEditingController();
    final TextEditingController _confirmation = TextEditingController();
    final FocusNode _focusName = FocusNode();
    final FocusNode _focusEmail = FocusNode();
    final FocusNode _focusPassword = FocusNode();
    final FocusNode _focusConfirmation = FocusNode();

    final provider = Provider.of<SignUpProvider>(context);

    return Form(
      child: Column(
        children: <Widget>[
          TextField(
            controller: _name,
            obscureText: false,
            textInputAction: TextInputAction.next,
            onSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_focusEmail),
            focusNode: _focusName,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              prefixIcon: Icon(Icons.person),
              hasFloatingPlaceholder: true,
              labelText: 'Name',
            ),
          ),
          SizedBox(height: 20.0),
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
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: TextField(
                  controller: _password,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_focusConfirmation),
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
              ),
              SizedBox(width: 10.0),
              Expanded(
                flex: 1,
                child: TextField(
                  controller: _confirmation,
                  obscureText: true,
                  onSubmitted: (_) => FocusScope.of(context).unfocus(),
                  focusNode: _focusConfirmation,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    contentPadding: EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                      left: 20.0,
                    ),
                    hasFloatingPlaceholder: true,
                    labelText: 'Confirmation',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
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
                  Either<Failure, FirebaseUser> result =
                      await provider.createUser(
                    name: _name.text,
                    email: _email.text,
                    password: _password.text,
                    photoUrl: '',
                  );
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
                  'Sign up',
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
