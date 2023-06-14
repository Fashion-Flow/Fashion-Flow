import 'package:fashion_flow/constants/colors.dart';
import 'package:fashion_flow/screens/login_screen.dart';
import 'package:flutter/material.dart';
import '';

void main() {
  runApp(const FfApp());
}

class FfApp extends StatelessWidget {
  const FfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.pink),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
