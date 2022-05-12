import 'package:flutter/material.dart';

class PatientLogin extends StatefulWidget {
  @override
  _PatientLoginState createState() => _PatientLoginState();
}

class _PatientLoginState extends State<PatientLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: "username"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(hintText: "Email"),
            ),
            ElevatedButton(
              child: Text("Login"),
              onPressed: () {},
            ),
          ]),
        ));
  }
}
