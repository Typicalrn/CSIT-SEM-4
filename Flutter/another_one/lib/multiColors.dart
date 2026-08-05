import 'package:flutter/material.dart';

class MultiColor extends StatelessWidget{
  const MultiColor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Container(
              height: double.infinity,
              width: 150,
              color: Colors.red,
              child: Center(child: Text('Red')),
            ),
            SizedBox(
              height: double.infinity,
              width: 200,
              // color: Colors.yellow,
              // child: Text('Container 2'),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 137,
                    color: Colors.yellow,
                    child: Center(child: Text('Yellow')),
                  ),

                  Container(
                    height: 100,
                    width: 137,
                    color: Colors.green,
                    child: Center(child: Text('Green')),
                  ),

                ],
              ),
            ),
            Container(
              height: double.infinity,
              width: 150,
              color: Colors.blue,
              child: Center(child: Text('Blue')),
            ),
          ],
        ),
      ),
    );
  }
}

