import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/services/database.dart';
import 'package:flutter_firebase/shared/constants.dart';
import 'package:flutter_firebase/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '10', '20', '30', '40', '50'];

  String currentName;
  int currentStrength;
  String currentSugars;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<BrewUser>(context);

    return StreamBuilder<BrewUserData>(
      stream: DatabaseService(uid: user.uid).brewUserData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          BrewUserData userData = snapshot.data;
          return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
              'Update your brew settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown)
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: userData.name,
                cursorColor: Colors.brown,
                onChanged: (val) => setState(() => currentName = val),
                validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                decoration: textInputDecoration.copyWith(hintText: 'name'),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField(
                decoration: textInputDecoration,
                value: currentSugars ?? userData.sugars,
                items: sugars.map((sugar) {
                  return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars')
                  );
                }).toList(),
                onChanged: (val) => setState(() => currentSugars = val),
              ),
              SizedBox(height: 20),
              Slider(
                value: (currentStrength ?? userData.strength).toDouble(),
                activeColor: Colors.brown[currentStrength ?? 100],
                inactiveColor: Colors.brown[currentStrength ?? 100],
                min: 100.0,
                max: 900.0,
                divisions: 8,
                onChanged: (val) => setState(() => currentStrength = val.round()),
              ),
              SizedBox(height: 20),
              RaisedButton(
                  color: Colors.brown[400],
                  child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white)
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await DatabaseService(uid: userData.uid).updateUserData(
                          currentName ?? userData.name, currentSugars ?? userData.sugars, currentStrength ?? userData.strength);
                      Navigator.pop(context);
                    }
                  }
              )
            ],
          ),
        );
        } else {
          return Loading();
        };
      }
    );
  }
}
