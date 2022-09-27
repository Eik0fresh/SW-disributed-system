import 'package:client/pages/patient/information.dart';
import 'package:client/pages/patient/registration/registration.dart';
import 'package:client/pages/patient/help.dart';
import 'package:client/pages/patient/login.dart';
import 'package:flutter/material.dart';

import 'package:barcode_scan2/barcode_scan2.dart';
//https://pub.dev/packages/barcode_scan2 add camera permission for all

class PatientHomePage extends StatefulWidget {
  @override
  _PatientHomePageState createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Patient"), centerTitle: true),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            button("Scan Registration QR Code", PatientInformation()),
            // ElevatedButton(
            //     onPressed: () async {
            //       var codeScan = await BarcodeScanner.scan();
            //       //todo
            //       //read from codeScan patientID, Name, Surname, load form from doctor side
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => RegistrationWindow()),
            //       );
            //     },
            //     child: const Text("Scan Registration QR Code"))
          ]),
          const SizedBox(
            height: 20,
          ),
          button("Help", PatientHelp()),
          const SizedBox(
            height: 20,
          ),
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
