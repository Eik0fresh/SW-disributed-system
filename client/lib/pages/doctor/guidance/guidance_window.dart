import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:client/pages/patient/patient.dart';
import 'package:qr_flutter/qr_flutter.dart';

//import 'containers/create_patient.dart';
//import 'containers/guidance.dart';
//import 'containers/qr_code.dart';

//PatientCreateState pcreate = PatientCreateState();
//GuidanceState gs = GuidanceState();
int dID = 0;

class GuidanceWindow extends StatefulWidget {
  @override
  _GuidanceWindowState createState() => _GuidanceWindowState();
}

class _GuidanceWindowState extends State<GuidanceWindow> {
// ###############     Variables    #############
//var patient
  final _formKey = GlobalKey<FormState>();
  RegExp emailExp = RegExp(
      '^[a-zA-Z0-9.!#\$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:.[a-zA-Z0-9-]+)*\$');
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  Patient patient = Patient("", "", "");

//var guidance
  String dropdownvalue = '...';
  var items = [
    '...',
    'Kopfschmerzen',
    'Knochenbruch',
    'Entfernung von einer Naht',
    'Krebs, Frühstadium',
  ];

//var qr-code
  TextEditingController qrcontroller = TextEditingController();
  bool qrvisibility = false;

//##############        Functions         ###############
// func Patient
  Future signup() async {
    var url = Uri.parse("http://ed-gateway:8080/patient/create");
    var reqBody = json.encode({
      'firstname': patient.firstname,
      'surname': patient.lastname,
      'email': patient.email
    });
    var res = await http.post(url,
        headers: {
          "Content-Type": 'application/json',
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "POST"
        },
        body: reqBody);
    return res.body;
  }

  bool validPatient() {
    //mark not filled textfields if they are empty/no valid email
    if (_formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

//############ func guidance #############
  Future createGuidance(pID) async {
    var url = Uri.parse("http://ed-gateway:8080/guidance/create");
    var reqBody = json.encode({
      //todo fix to api, add date?
      'g_ID': patient.firstname,
      'p_ID': pID,
      'd_ID': patient.email
    });
    var res = await http.post(url,
        headers: {
          "Content-Type": 'application/json',
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "POST"
        },
        body: reqBody);
    return res.body;
  }

//############ func qr Code ##############
  createQRCode() {
    if (validPatient() == true) {
      if (dropdownvalue != '...') {
        //todo change res.body to patient ID
        var pID = signup();
        //createGuidance(pID);
        qrvisibility = true;
        setState(() {});
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("Keine Diagnose ausgewählt."),
            );
          },
        );
      }
    }
  }

//################   Widget   ##############

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create Guidance"),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
                child: Column(children: <Widget>[
              //Patient
              Container(
                child: Column(
                  children: <Widget>[
                    const Text('Patientdata'),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter valid name';
                                }
                                return null;
                              },
                              decoration:
                                  const InputDecoration(hintText: "First Name"),
                              controller: firstname,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter valid name';
                                }
                                return null;
                              },
                              decoration:
                                  const InputDecoration(hintText: "Last Name"),
                              controller: lastname,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (!value!.contains(emailExp)) {
                                  return 'Please enter valid email';
                                }
                                return null;
                              },
                              decoration:
                                  const InputDecoration(hintText: "Email"),
                              controller: email,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    /*
                    Container(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        child: const Text("Submit"),
                        onPressed: () async {
                          patient.firstname = firstname.text;
                          patient.lastname = lastname.text;
                          patient.email = email.text;
                          signup();
                        },
                      ),
                    ),*/
                  ],
                ),
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(10),
                //height: 800,
                decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    border: Border.all(width: 5, color: Colors.green),
                    borderRadius: BorderRadius.circular(30)),
              ),

//Guidance
              Container(
                child: Center(
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                            child: Column(children: <Widget>[
                          Text('DoctorID: ' + dID.toString()),
                          const Text(
                              'Die Diagnosen werden aus der DB geladen (oder vom anderen Program importiert \n mehrere Diagnose auswählbar (?))'),
                          Row(children: <Widget>[
                            const Text('wählen Sie die Diagnose aus:'),
                            DropdownButton(
                              // Initial Value
                              value: dropdownvalue,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                });
                              },
                            ),
                          ]),
                          const TextField(
                            decoration: InputDecoration(
                                hintText:
                                    "PatientID, imported from creat/load patient page"),
                          ),
                        ])))),
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(10),
                height: 220,
                decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    border: Border.all(width: 5, color: Colors.blue),
                    borderRadius: BorderRadius.circular(30)),
              ),
//qrCode
              Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: qrvisibility,
                        child: QrImage(
                          data: qrcontroller.text,
                          size: 150,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: TextField(
                          controller: qrcontroller,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter URL'),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            createQRCode();
                          },
                          child: const Text('GENERATE QR')),
                    ],
                  ),
                ),
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(10),
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    border: Border.all(width: 5, color: Colors.green),
                    borderRadius: BorderRadius.circular(30)),
              ),
            ]))));
  }
}
