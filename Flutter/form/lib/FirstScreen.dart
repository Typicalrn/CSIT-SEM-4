import 'package:flutter/material.dart';
import 'package:form/SecondScreen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final String name = 'John Doe'; // Example name to pass to SecondScreen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
        backgroundColor: const Color.fromARGB(255, 81, 118, 104),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SecondScreen(name: name)),
                    );
                    // Navigator.pushNamed(context, '/second');
                  },
                  child: const Text('Second Screen'),
                ),
                const SizedBox(height: 16.0),
                // ElevatedButton(
                //   onPressed: () {
                //     // Navigator.push(
                //     //   context,
                //     //   MaterialPageRoute(builder: (context) => SecondScreen()),
                //     // );
                //     Navigator.pushNamed(context, '/third');
                //   },
                //   child: const Text('Third Screen'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}