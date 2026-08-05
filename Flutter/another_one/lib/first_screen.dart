import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("First Screen")),
              backgroundColor: const Color.fromARGB(255, 108, 54, 54),
      body: SafeArea(
        child: Center(
          child: Text("This is the first screen", style: TextStyle(fontSize: 24, color: Colors.white,letterSpacing:10)),
        ),
      ),
    );
  }
}