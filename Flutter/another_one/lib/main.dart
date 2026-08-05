import 'package:flutter/material.dart';
// import 'package:another_one/first_screen.dart';
// import 'package:another_one/second_screen.dart';
import 'package:another_one/multicolors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MultiColor());
  }
}
