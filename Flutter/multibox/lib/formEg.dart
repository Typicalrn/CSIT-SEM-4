import 'package:flutter/material.dart';

class AddingScreen extends StatefulWidget {
  const AddingScreen({super.key});

  @override
  State<AddingScreen> createState() => _AddingScreenState();
}

class _AddingScreenState extends State<AddingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adding Number'),),
      body:SafeArea(child: 
        Padding(
          padding:EdgeInsetsGeometry.all(15),
          child: Form(
            child: Column(children: [
              
            ],),
          )
        )
      )
    );
  }
}