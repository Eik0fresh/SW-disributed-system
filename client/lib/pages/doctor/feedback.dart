import 'package:flutter/material.dart';

class GetFeedback extends StatefulWidget {
  @override
  _GetFeedbackState createState() => _GetFeedbackState();
}

class _GetFeedbackState extends State<GetFeedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Get feedback from patient"),
      ),
    );
  }
}
