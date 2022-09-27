import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var firstnameRegistration = '';
var surnameRegistration = '';
var patientIDRegistration = '';

class RegistrationWindow extends StatefulWidget {
  @override
  _RegistrationWindowState createState() => _RegistrationWindowState();
}

class _RegistrationWindowState extends State<RegistrationWindow> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController patientEmail = TextEditingController();
  TextEditingController pwd = TextEditingController();

  bool validInput() {
    //mark not filled textfields if they are empty/no valid email
    if (_formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  Future registration() async {
    //registration needs to be installed in backend
    var url = Uri.parse("http://ed-gateway:8080/patient/registration");
    var reqBody = json.encode({
      'pID': patientIDRegistration,
      'password': pwd.text,
      'email': patientEmail.text
    });

    var res = await http.post(url,
        headers: {
          "Content-Type": 'application/json',
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "POST"
        },
        body: reqBody);
    return res.statusCode;
  }

  registrationCheck() async {
    if (validInput()) {
      var status = await registration();
      if (status == 200) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("Anmeldung Erfolgreich"),
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("Ohje, hier ist etwas Schief gelaufen."),
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Letzten Schritte der Registrierung"),
            centerTitle: true),
        body: Padding(
            padding: EdgeInsets.all(20),
            child: Center(
                child: Column(children: <Widget>[
              Row(
                children: <Widget>[
                  const Text(
                    'Name: ',
                    textScaleFactor: 2,
                  ),
                  Text(
                    firstnameRegistration,
                    textScaleFactor: 2,
                  ),
                  const Text('  '),
                  Text(
                    surnameRegistration,
                    textScaleFactor: 2,
                  ),
                ],
              ),
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter valid Email';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(hintText: "Email"),
                          controller: patientEmail,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter valid Passwort';
                            }
                            return null;
                          },
                          decoration:
                              const InputDecoration(hintText: "Passwort"),
                          controller: pwd,
                        ),
                      ],
                    ),
                  )),
              ElevatedButton(
                  onPressed: () {
                    registrationCheck();
                  },
                  child: const Text('Registrieren'))
            ]))));
  }
}
