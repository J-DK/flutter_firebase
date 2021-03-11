import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/auth.dart';
import 'package:flutter_firebase/shared/constants.dart';

class Register extends StatefulWidget {

  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String email = '';
  String password = '';
  String error = '';

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: Text('Sign up to Brew Crew'),
        actions: [
            FlatButton.icon(
                onPressed: () {
                  widget.toggleView();
                },
                icon: Icon(Icons.person),
                label: Text('Sign In'))
          ]
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                  validator: (val) {
                     return val.isEmpty ? 'Enter an email' : null;
                  },
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
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
                        'Register',
                        style: TextStyle(
                            color: Colors.white
                        )
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() {
                            error = 'Please provide a valid email';
                          });
                        }
                      }
                    }
                ),
                SizedBox(height: 20),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                )
              ],
            ),
          )
      ),
    );
  }
}
