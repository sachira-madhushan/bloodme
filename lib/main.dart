import 'package:bloodme/screens/home.dart';
import 'package:bloodme/screens/login.dart';
import 'package:bloodme/screens/signin.dart';
import 'package:bloodme/screens/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 64, 0)),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
