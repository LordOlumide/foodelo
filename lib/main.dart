import 'package:flutter/material.dart';

// screens
import 'package:foodelo/screens/home_screen/home_screen.dart';
import 'package:foodelo/screens/loading_screen/loading_screen.dart';
import 'package:foodelo/screens/login_screen/login_screen.dart';
import 'package:foodelo/screens/registration_screen/registration_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodelo',
      initialRoute: LoadingScreen.screenId,
      routes: {
        LoadingScreen.screenId: (context) => const LoadingScreen(),
        HomeScreen.screenId: (context) => HomeScreen(),
        RegistrationScreen.screenId: (context) => RegistrationScreen(),
        LoginScreen.screenId: (context) => LoginScreen(),
      },
    );
  }
}
