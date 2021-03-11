import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/shared/constants.dart';
import 'package:flutter_firebase/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  String email = '';
  String password = '';
  String error = '';

  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: Text('Sign in to Brew Crew'),
        actions: [
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Register')
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                cursorColor: Colors.brown,
                onChanged: (val) {
                  setState(() => email = val);
                },
                validator: (val) {
                  return val.isEmpty ? 'Enter your email' : null;
                },
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                cursorColor: Colors.brown,
                onChanged: (val) {
                  setState(() => password = val);
                },
                validator: (val) {
                  return val.length < 6 ? 'Enter a password 6+ chars long ' : null;
                },
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
              ),
              SizedBox(height: 20),
              RaisedButton(
                color: Colors.brown[400],
                child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white
                    )
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        error = 'Could not sign in with the provided credentials';
                        loading = false;
                      });
                    }
                  }
                }
              ),
              SizedBox(height: 20),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold)
              )
            ],
          ),
        )
      ),
    );
  }
}
