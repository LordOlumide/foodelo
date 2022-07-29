import 'package:flutter/material.dart';
import 'multi_screen_ui_comps/custom_rounded_button.dart';
// screens
import 'package:foodelo/screens/login_screen.dart';
import 'package:foodelo/screens/registration_screen.dart';
import 'package:foodelo/screens/verify_email_screen.dart';
import 'package:foodelo/screens/forgot_password_screen_1.dart';

class WelcomeScreen extends StatelessWidget {
  static const screenId = 'Welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  // TODO: use Provider to supply a single instance of NetworkHelper() everywhere
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Verify Email Button
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => VerifyEmailScreen(),
                    ));
                  },
                  child: const Text(
                    'Verify email',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),

                // Forgot password button
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen(),
                    ));
                  },
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
