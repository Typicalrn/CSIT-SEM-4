//import 'package:form/fixed.dart';
//import 'package:form/shifting.dart';
import 'package:flutter/material.dart';
// import 'package:form/login_Screen.dart';
// import 'package:form/register_Screen.dart';
import 'package:form/FirstScreen.dart';
// import 'package:form/SecondScreen.dart';
// import 'package:form/ThirdScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstScreen(),
      // initialRoute: '/',
      // routes: {
      //   // '/': (context) => FirstScreen(),
      //   // '/second':(context) => SecondScreen(),
      //   // '/third':(context) => ThirdScreen(),
      //   // '/': (context) => const LoginScreen(),
      //   // '/register': (context) => const RegisterScreen(),
      // },
    );
  }
}
