import 'package:flutter/material.dart';

class PatientSignup extends StatefulWidget {
  @override
  _PatientSignupState createState() => _PatientSignupState();
}

class _PatientSignupState extends State<PatientSignup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: "First Name"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(hintText: "Last Name"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(hintText: "Birthday"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(hintText: "Email Address"),
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
