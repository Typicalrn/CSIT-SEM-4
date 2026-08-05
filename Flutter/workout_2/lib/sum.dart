import 'package:flutter/material.dart';

class SumExample extends StatefulWidget {
  const SumExample({super.key});
  @override
  State<SumExample> createState() => _SumExampleState();
}

class _SumExampleState extends State<SumExample> {
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  String value1 = '';
  String value2 = '';
  String result = '';
  bool _validate1 = false;
  bool _validate2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                // Step 2: assign controller to the textfield
                controller: myController1,
                decoration: InputDecoration(
                  hintText: "Enter first string",
                  labelText: "Message 1",
                  border: const OutlineInputBorder(),
                  errorText: _validate1 ? "Cannot be empty" : null,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: myController2,
                decoration: InputDecoration(
                  hintText: "Enter second string",
                  labelText: "Message 2",
                  border: const OutlineInputBorder(),
                  errorText: _validate2 ? "Cannot be empty" : null,
                ),
              ),
      const SizedBox(height: 50),
              Text(result),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    value1 = myController1.text;
                    value2 = myController2.text;
                    _validate1 = value1.isEmpty;
                    _validate2 = value2.isEmpty;
                    result = (_validate1 || _validate2) ? '' : value1 + value2;
                  });
                },
                child: const Text('GET'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}