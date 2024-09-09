import 'package:flutter/material.dart';
import 'package:projet_wala_soa/Views/HomePage.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
      },
    ),
  );
}
