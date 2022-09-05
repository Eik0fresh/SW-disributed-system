import 'dart:convert';

import 'package:client/pages/doctor/doctor.dart';
import 'package:client/pages/doctor/guidance/guidance_window.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DoctorLogin extends StatefulWidget {
  @override
  _DoctorLoginState createState() => _DoctorLoginState();
}

class _DoctorLoginState extends State<DoctorLogin> {
  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  Doctor doc = Doctor("", "");

  Future login() async {
    var url = Uri.parse("http://ed-gateway:8080/doctor/query");
    var reqbody =
        json.encode({'firstname': doc.firstname, 'surname': doc.lastname});
    var res = await http.post(url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: reqbody);
    var parsedJson = json.decode(res.body);
    dID = parsedJson['d_id'];

    if (res.body != '') {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GuidanceWindow(),
          ));
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Something went wrong, try again!"),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Doctor Login"),
          centerTitle: true,
        ),
        body: Center(
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
              child: const Text("login"),
              onPressed: () {
                doc.firstname = _firstname.text;
                doc.lastname = _lastname.text;
                login();
              },
            ),
          ]),
        ));
  }
}
