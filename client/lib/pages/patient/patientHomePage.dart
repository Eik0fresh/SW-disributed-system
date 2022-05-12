import 'package:client/pages/patient/patientHelp.dart';
import 'package:client/pages/patient/patientLogin.dart';
import 'package:client/pages/patient/patientSignup.dart';
import 'package:flutter/material.dart';

class PatientHomePage extends StatefulWidget {
  @override
  _PatientHomePageState createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Patient"), centerTitle: true),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          button("Login", PatientLogin()),
          SizedBox(
            height: 20,
          ),
          button("Signup", PatientSignup()),
          SizedBox(
            height: 20,
          ),
          button("Q&A", PatientHelp()),
        ],
      )),
    );
  }

  Widget button(String text, Widget widget) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget),
        );
      },
      child: Text(text),
    );
  }
}
