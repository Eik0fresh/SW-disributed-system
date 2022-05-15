import 'dart:convert';

import 'package:client/pages/patient/patient.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PatientFeedback extends StatefulWidget {
  @override
  _PatientFeedbackState createState() => _PatientFeedbackState();
}

class _PatientFeedbackState extends State<PatientFeedback> {
  TextEditingController _feedback = TextEditingController();
  Patient patient = Patient("", "");

  Future send() async {
    var url = Uri.parse("localhost:8080/patient/createFeedback");
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
        title: Text("Feedback"),
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
              decoration: InputDecoration(hintText: "diagnosis_id"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(hintText: "feedback"),
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
