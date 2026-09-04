import 'package:flutter/material.dart';

class RetrieveExample extends StatefulWidget {
  const RetrieveExample({super.key});

  @override
  State<RetrieveExample> createState() => _RetrieveExampleState();
}

class _RetrieveExampleState extends State<RetrieveExample> {
  // Step 1: Creating instance of TextEditingController
  final myController = TextEditingController();
  String value = '';
  bool _validate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              // Step 2: assign controller to the textfield
              controller: myController,
              decoration: InputDecoration(
                hintText: "Enter your message",
                labelText: "Message",
                border: OutlineInputBorder(),
                errorText: _validate ? "Cannot be empty" : null,
              ),
            ),
            const SizedBox(height: 50),
            Text(value),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  value = myController.text;
                  value.isEmpty ? _validate = true : _validate = false;
                });
              },
              child: const Text('GET'),
            ),
          ],
        ),
      ),
    );
  }
}