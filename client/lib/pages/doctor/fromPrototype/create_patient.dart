import 'dart:convert';

//import 'package:client/pages/patient/patient.dart';
import 'package:client/pages/doctor/fromPrototype/guidance.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PatientSignup extends StatefulWidget {
  @override
  _PatientSignupState createState() => _PatientSignupState();
}

class _PatientSignupState extends State<PatientSignup> {
  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  TextEditingController _email = TextEditingController();
  Patient patient = Patient("", "", "");

  Future signup() async {
    var url = Uri.parse("http://ed-gateway:8080/patient/create");
    var req_body = json.encode({
      'firstname': patient.firstname,
      'surname': patient.lastname,
      'email': patient.email
    });
    var res = await http.post(url,
        headers: {
          "Content-Type": 'application/json',
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "POST"
        },
        body: req_body);

    if (res.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Sign up successfully"),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            //todo add ID or add Button to remove Alert
            content: Text("Patient existiert schon. Die ID lautet:"),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registriere Patient"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
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
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(hintText: "Email"),
                controller: _email,
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                child: const Text("Submit"),
                onPressed: () async {
                  patient.firstname = _firstname.text;
                  patient.lastname = _lastname.text;
                  patient.email = _email.text;
                  signup();
                },
              ),
              ElevatedButton(
                  child: const Text("Weiter"),
                  onPressed: () async {
                    patient.firstname = _firstname.text;
                    patient.lastname = _lastname.text;
                    patient.email = _email.text;
                    signup();
                    patientdata = [
                      patient.firstname,
                      patient.lastname,
                      patient.email
                    ];
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Guidance()),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

//later remove Submit and throw error in "weiter"