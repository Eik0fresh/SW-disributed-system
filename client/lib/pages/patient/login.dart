import 'dart:convert';

import 'package:client/pages/patient/information.dart';
import 'package:flutter/material.dart';
import 'package:client/pages/patient/patient.dart';
import 'package:http/http.dart' as http;

class PatientLogin extends StatefulWidget {
  @override
  _PatientLoginState createState() => _PatientLoginState();
}

class _PatientLoginState extends State<PatientLogin> {
  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  Patient patient = Patient("", "", "");

  Future login() async {
    var url = Uri.parse("http://localhost:8080/patient/createPatient");
    var req_body = json
        .encode({'firstname': patient.firstname, 'surname': patient.lastname});
    var res = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: req_body);

    if (res.statusCode == 201) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PatientInformation(),
          ));
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text(
                "No patient exists, please sign up first with the QR Code!"),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(40),
            child: Center(
              child: Column(children: <Widget>[
                TextField(
                  decoration: const InputDecoration(hintText: "First Name"),
                  controller: _firstname,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: const InputDecoration(hintText: "Last Name"),
                  controller: _lastname,
                ),
                ElevatedButton(
                  child: const Text("submit"),
                  onPressed: () {
                    patient.firstname = _firstname.text;
                    patient.lastname = _lastname.text;
                    login();
                  },
                ),
              ]),
            )));
  }
}
