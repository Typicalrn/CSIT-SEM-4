import "package:flutter/material.dart";

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[500],
      appBar: AppBar(title: const Text('My Card')),

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('assets/images/tail.png'),
            ),

            Text(
              'Aryan Maharjan',
              style: TextStyle(
                fontFamily: 'Audiowide',
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.5,
              ),
            ),

            Text(
              'Student',
              style: TextStyle(
                fontFamily: 'Audiowide',
                fontSize: 25,
                color: const Color.fromARGB(255, 217, 78, 39),
                fontWeight: FontWeight.bold,
                letterSpacing: 2.5,
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              padding: EdgeInsets.all(10.0),
              color: Colors.white,
              child: Row(
                children: [
                  Icon(Icons.phone, color: Colors.teal[500]),
                  SizedBox(width: 10.0),
                  Text(
                    '+977 986-0**34567',
                    style: TextStyle(fontSize: 20, color: Colors.teal[500]),
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              padding: EdgeInsets.all(10.0),
              color: Colors.white,
              child: Row(
                children: [
                  Icon(Icons.email, color: Colors.teal[500]),
                  SizedBox(width: 10.0),
                  Text(
                    'xyz@gmail.com',
                    style: TextStyle(fontSize: 20, color: Colors.teal[500]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
