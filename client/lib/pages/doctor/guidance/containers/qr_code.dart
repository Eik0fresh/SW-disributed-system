import 'package:flutter/material.dart';

Widget qrCode() {
  return Container(
    child: const Center(child: Text('banana')),
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.all(10),
    height: 300,
    decoration: BoxDecoration(
        color: Colors.lightGreen,
        border: Border.all(width: 5, color: Colors.green),
        borderRadius: BorderRadius.circular(30)),
  );
}
