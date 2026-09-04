import 'package:flutter/material.dart';

class BottomNavEx extends StatefulWidget {
  const BottomNavEx({super.key});

  @override
  _BottomNavExState createState() => _BottomNavExState();
}

class _BottomNavExState extends State<BottomNavEx> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static const List<Widget> _widgetOption = [
    Text(
      'Index 0:Home Page',
      style: optionStyle,
    ),
    Text(
      'Index 1:Business',
      style: optionStyle,
    ),
    // Image.asset('images/myimage.jpeg'),
    Text(
      'Index 2:school',
      style: optionStyle,
    ),
    Text(
      'Index 3:Settings',
      style: optionStyle,
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: _widgetOption.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.business,
            ),
            label: 'Business',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.school,
            ),
            label: 'School',
            backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.yellow,
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.amber[900],
        // backgroundColor: Colors.teal,
        onTap: _onItemTapped,
      ),
    );
  }
}