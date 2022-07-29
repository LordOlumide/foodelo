import 'package:flutter/material.dart';

// screens
import 'package:foodelo/screens/home_screen/home_screen.dart';
import 'package:foodelo/screens/welcome_screen.dart';
import 'package:foodelo/screens/login_screen.dart';
import 'package:foodelo/screens/registration_screen.dart';
import 'package:foodelo/screens/confirm_email_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodelo',
      initialRoute: WelcomeScreen.screenId,
      routes: {
        WelcomeScreen.screenId: (context) => const WelcomeScreen(),
        HomeScreen.screenId: (context) => HomeScreen(),
        RegistrationScreen.screenId: (context) => RegistrationScreen(),
        ConfirmEmailScreen.screenId: (context) => ConfirmEmailScreen(),
        LoginScreen.screenId: (context) => LoginScreen(),
      },
    );
  }
}
