import 'package:fashion_flow/constants/colors.dart';
import 'package:fashion_flow/screens/login_screen.dart';
import 'package:fashion_flow/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FfApp());
}

class FfApp extends StatelessWidget {
  const FfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.pink),
      debugShowCheckedModeBanner: false,
      home: RegistrationScreen(),
    );
  }
}
