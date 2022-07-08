import 'package:client/pages/doctor/guidance/guidance_window.dart';
import 'package:flutter/material.dart';

// Initial Selected Value
String dropdownvalue = '...';

// List of items in our dropdown menu
var items = [
  '...',
  'Kopfschmerzen',
  'Knochenbruch',
  'Entfernung von einer Naht',
  'Krebs, Frühstadium',
];

Widget guidanceContainer = Container(
  child: Center(
      child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
              child: Column(children: <Widget>[
            const Text(
                'Die Diagnosen werden aus der DB geladen (oder vom anderen Program importiert \n mehrere Diagnose auswählbar (?))'),
            Row(children: <Widget>[
              const Text('wählen Sie die Diagnose aus:'),
              /*DropdownButton(
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
                //onChanged: (String? newValue) {
                //  setState(
                //    dropdownvalue = newValue!
                //  );
                },
              ),*/
            ]),
            const TextField(
              decoration: InputDecoration(
                  hintText: "PatientID, imported from creat/load patient page"),
            ),
          ])))),
  margin: const EdgeInsets.all(5),
  padding: const EdgeInsets.all(10),
  height: 300,
  decoration: BoxDecoration(
      color: Colors.lightBlue,
      border: Border.all(width: 5, color: Colors.blue),
      borderRadius: BorderRadius.circular(30)),
);
