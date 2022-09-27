import 'package:client/pages/doctor/fromPrototype/diagnosis.dart';
import 'package:client/pages/doctor/feedback/feedback.dart';
import 'package:client/pages/doctor/guidance/guidance_window.dart';
import 'package:client/pages/doctor/login/login.dart';
import 'package:client/pages/doctor/fromPrototype/create_patient.dart';
import 'package:client/pages/doctor/fromPrototype/guidance.dart';
import 'package:flutter/material.dart';
import 'package:client/pages/doctor/guidance/containers/qrcode.dart';

class DoctorHomePage extends StatefulWidget {
  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Doctor"), centerTitle: true),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //button("Lade Patient", PatientSignup()),
          button("Login", DoctorLogin()),
          const SizedBox(
            height: 20,
          ),
          button("Create Guidance", GuidanceWindow()),
          const SizedBox(
            height: 20,
          ),

          ///button("Diagnosis", CreateDiagnosis()),
          //SizedBox(
          //  height: 20,
          //),
          button("Feedback", GetFeedback())
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
