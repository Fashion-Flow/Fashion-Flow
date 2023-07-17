import 'dart:js';

import 'package:fashion_flow/constants/colors.dart';
import 'package:fashion_flow/screens/home_screen.dart';
import 'package:fashion_flow/screens/login_screen.dart';
import 'package:fashion_flow/screens/registration_screen.dart';
import 'package:fashion_flow/services-auth/auth_gate.dart';
import 'package:fashion_flow/services-auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:image_picker_android/image_picker_android.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

void main() async {
  final ImagePickerPlatform imagePickerImplementation =
      ImagePickerPlatform.instance;
  if (imagePickerImplementation is ImagePickerAndroid) {
    imagePickerImplementation.useAndroidPhotoPicker = true;
  }

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      ChangeNotifierProvider(
        create: (context)=> AuthService(),
        child: const FfApp(),
      ),
  );
}

class FfApp extends StatelessWidget {
  const FfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.pink),
        debugShowCheckedModeBanner: false,
        home: AuthGate(),//HomeScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegistrationScreen(),
          '/home': (context) => const HomeScreen(),
        });
  }
}
