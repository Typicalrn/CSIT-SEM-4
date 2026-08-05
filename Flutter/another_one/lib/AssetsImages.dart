import 'package:flutter/material.dart';

class AssetsImage extends StatelessWidget {
  const AssetsImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/Login_Authentication.png')),
            Text("Demo of asset image", style: TextStyle(color: const Color.fromARGB(255, 116, 71, 71),fontFamily: 'Roboto',fontSize: 20,letterSpacing: 2)),
          ],
        ),
      ),
    );
  }
}