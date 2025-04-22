import 'package:flutter/material.dart';
import 'package:netflix/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Netflix Clone',
      theme: ThemeData.dark(),
      home: HomeScreen(), // Using HomeScreen widget from home_screen.dart
    );
  }
}
