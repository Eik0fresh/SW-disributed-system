import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:flutter/material.dart';
//requests
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:client/pages/patient/patient.dart';
//qr
import 'package:barcode/barcode.dart';
import 'package:barcode_widget/barcode_widget.dart';
//import 'package:qr_flutter/qr_flutter.dart';
//jpg
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

import 'package:xml/xml.dart';

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

class FetchData {
  data(idc) async {
    //translate idc to text from xml
    final loadfile = File('icd10gm_short.xml');
    final document = XmlDocument.parse(loadfile.readAsStringSync());
    final titles = document.findAllElements('Class');
    for (var element in titles) {
      if (element.attributes.first.value == idc) {
        var result = element.getElement('Rubric')?.text;
        result?.replaceAll(' ', '');
        result?.replaceAll('\n', '');
        //why graphic bug
        return result;
      }
    }
    return '';
  }
}

class _GuidanceWindowState extends State<GuidanceWindow> {
// ###############     Variables    #############
//var patient
  var patientInfoShown = false;
  var patientfirstname = "Patient1";
  var patientsurname = "";
  var birthday = "1.1.1899";
  final _formKey = GlobalKey<FormState>();
  TextEditingController patientID = TextEditingController();
  Patient patient = Patient("", "", "");

//var diagnosis
  var idc = "";
  TextEditingController idcController = TextEditingController();
  FetchData icdxml = FetchData();

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

  Future query() async {
    var url =
        Uri.parse("http://ed-gateway:8080/patient/query/${patientID.text}");
    final res = await http.get(
      url, /*headers: {
      "Content-Type": 'application/json',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "POST"
    }*/
    );
    var responseData = json.decode(res.body);
    patientfirstname = responseData["firstname"];
    patient.firstname = patientfirstname;
    patientsurname = responseData["surname"];
    patient.lastname = patientsurname;
    patient.email = responseData["email"];
    //DtoEmail, but birthday useful to make a patient 99,9% unique
    //birthday = responseData["birthday"];
    signup();
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

  setIDC(idcController) async {
    if (idcController.length == 3 || idcController.length > 4) {
      idc = await icdxml.data(idcController);
    } else {
      idc = '';
    }
    setState(() {});
  }

//############ func qr Code ##############
  createQRCode() async {
    if (validPatient() == true) {
      if (idc != '') {
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

  var pdf = pw.Document();
  writeOnPdf() {
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Header(
                level: 0,
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      pw.Text(
                        'Scan QR Code um die Diagnosen in der App anzusehen.',
                      ),
                      pw.Column(children: [
                        pw.BarcodeWidget(
                            data: 'Hello World',
                            width: 100,
                            height: 100,
                            barcode: pw.Barcode.qrCode()),
                      ]),
                    ])),
          ];
        }));
  }

  Future saveQRCodeaspdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/example.pdf");
    await file.delete();
    file.writeAsBytes(await pdf.save());
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
                child: ListView(children: <Widget>[
              Text('DoctorID: ' + dID.toString()),
              //Patient
              Container(
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Patientdata',
                      textScaleFactor: 2,
                    ),
                    const Text(
                      'Bsp:2395151',
                    ),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(7),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter valid ID';
                                }
                                return null;
                              },
                              decoration:
                                  const InputDecoration(hintText: "Patient-ID"),
                              controller: patientID,
                              onChanged: (patientID) async {
                                if (patientID.length == 7) {
                                  await query();
                                  patientInfoShown = true;
                                } else {
                                  patientInfoShown = false;
                                }
                                setState(() {});
                              },
                            ),
                            Visibility(
                              visible: patientInfoShown,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    Text(
                                      patientfirstname,
                                      textScaleFactor: 1.5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Text(
                                        patientsurname,
                                        textScaleFactor: 1.5,
                                      ),
                                    ),
                                    Text(
                                      birthday,
                                      textScaleFactor: 1.5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  await query();
                                  patientInfoShown = true;
                                  setState(() {});
                                },
                                child: const Text('Load Patient')),
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
                          const Text(
                            'Bsp:B57.2',
                          ),
                          TextFormField(
                            //may two fields with focus switch are better (no .)
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6),
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter ICD';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(hintText: "ICD"),
                            controller: idcController,
                            onChanged: (idcController) {
                              {
                                setIDC(idcController);
                                setState(() {});
                              }
                            },
                          ),
                          Text(idc),
                        ])))),
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(10),
                height: 200,
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
                        child: BarcodeWidget(
                          barcode: Barcode.qrCode(),
                          data: "Hello World",
                          width: 100,
                          height: 100,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: TextField(
                          controller: qrcontroller,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter Test - URL'),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            createQRCode();
                          },
                          child: const Text('GENERATE QR')),
                      ElevatedButton(
                          onPressed: () async {
                            writeOnPdf();
                            await saveQRCodeaspdf();
                            pdf = pw.Document();
                          },
                          child: const Text('Save QR'))
                    ],
                  ),
                ),
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(10),
                height: 320,
                decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    border: Border.all(width: 5, color: Colors.green),
                    borderRadius: BorderRadius.circular(30)),
              ),
            ]))));
  }
}
