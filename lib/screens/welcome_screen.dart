import 'package:flutter/material.dart';
import 'multi_screen_ui_comps/custom_rounded_button.dart';
import 'package:foodelo/general_components/push_error_screen.dart';

// screens
import 'package:foodelo/screens/login_screen.dart';
import 'package:foodelo/screens/registration_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const screenId = 'Welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // "Foodelo" header
            const Text(
              'Foodelo',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 40.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),

            // Login button
            CustomRoundedButton(
              text: 'Log In',
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.screenId);
              },
              color: Colors.lightBlueAccent,
            ),

            // Register button
            CustomRoundedButton(
              text: 'Register',
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.screenId);
              },
              color: Colors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
