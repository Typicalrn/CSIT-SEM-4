import 'package:flutter/material.dart';

class ButtonScreen extends StatefulWidget {
  const ButtonScreen({super.key});

  @override
  State<ButtonScreen> createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(padding: EdgeInsetsGeometry.all(15), child: Column(
        children: [
          TextButton(onPressed: (){}, child: Text('Txt Btn')),
          SizedBox(height: 30),
          ElevatedButton(onPressed: (){}, child: Text('Elv Btn')),
          SizedBox(height: 30),
          OutlinedButton(onPressed: (){}, child: Text('Outlin Btn')),
        ],
      )))
    );
  }
}