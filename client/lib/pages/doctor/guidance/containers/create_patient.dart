import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:client/pages/patient/patient.dart';

class PatientCreate extends StatefulWidget {
  @override
  PatientCreateState createState() => PatientCreateState();
}

class PatientCreateState extends State<PatientCreate> {
  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  TextEditingController _email = TextEditingController();
  Patient patient = Patient("", "", "");

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
            ],
          ),
        ),
      ),
    );
  }

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

  Widget signUp() {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(hintText: "First Name"),
                controller: _firstname,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: const InputDecoration(hintText: "Last Name"),
                controller: _lastname,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: const InputDecoration(hintText: "Email"),
                controller: _email,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  child: const Text("Submit"),
                  onPressed: () async {
                    patient.firstname = _firstname.text;
                    patient.lastname = _lastname.text;
                    patient.email = _email.text;
                    signup();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      //height: 800,
      decoration: BoxDecoration(
          color: Colors.lightGreen,
          border: Border.all(width: 5, color: Colors.green),
          borderRadius: BorderRadius.circular(30)),
    );
  }
}
