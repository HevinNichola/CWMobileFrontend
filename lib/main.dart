
import 'package:eco_enforce/screen/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoEnforceSystem',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Color(
            0xFFF4FAF6)),
          primarySwatch: Colors.teal,
          scaffoldBackgroundColor: Colors.white),
      home: const WelcomeScreen(),
    );
  }
}

