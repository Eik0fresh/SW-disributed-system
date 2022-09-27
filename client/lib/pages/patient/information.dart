import 'package:client/pages/patient/feedback.dart';
import 'package:flutter/material.dart';

class PatientInformation extends StatefulWidget {
  @override
  _PatientInformationState createState() => _PatientInformationState();
}

class _PatientInformationState extends State<PatientInformation> {
  bool _switchState=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diagnosis"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Patient's personal information here."),
            SizedBox(
              height: 20,
            ),
            Text("Diagnosis here."),
            SizedBox(
              height: 20,
            ),
            Text("Guidance here."),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Done guidance"),
                Switch(
                  value: _switchState, 
                  onChanged: (value) {
                    setState(() {
                      _switchState=value;
                    });
                  }
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            button("Feedback", PatientFeedback())
          ],
        ),
      ),
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
