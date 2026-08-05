//container
import 'package:flutter/material.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          // crossAxisAlignment:
          //     CrossAxisAlignment.start, //up, down, center, stretch, start
          // mainAxisAlignment: MainAxisAlignment
          //     .start, //up, down, center, spaceBetween, spaceAround
          children: [
            Container(
              height: 200,
              width: 300,
              color: const Color.fromARGB(255, 110, 145, 174),
              child: Text('Container 1', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),
            Container(
              height: 200,
              width: double
                  .infinity, //double.infinity means it will take the full width of the screen
              color: const Color.fromARGB(255, 139, 165, 160),
              child: Text('Container 2', style: TextStyle(color: Colors.white)),
            ),
            Text("Demo of third screen", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 188, 184, 142),
    );
  }
}