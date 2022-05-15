import 'dart:convert';

import 'package:client/pages/doctor/doctor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateDiagnosis extends StatefulWidget {
  @override
  _CreateDiagnosisState createState() => _CreateDiagnosisState();
}

class _CreateDiagnosisState extends State<CreateDiagnosis> {
  TextEditingController _feedback = TextEditingController();
  Doctor patient = Doctor("", "");

  Future send() async {
    var url = Uri.parse("localhost:8080/diagnosis/createDiagnosis");
    var req_body = json
        .encode({'username': patient.firstname, 'password': patient.lastname});
    var res = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: req_body);

    if (res.body == req_body) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Sign up successfully"),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Patient exists, please log in"),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diagnosis"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: "patient_id"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(hintText: "doctor_id"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(hintText: "diagnosis"),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              child: Text("Submit"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
