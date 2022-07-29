import 'package:flutter/material.dart';
import 'package:foodelo/network_helper.dart';
// components
import 'package:foodelo/screens/multi_screen_ui_comps/'
    'custom_rounded_button.dart';
import 'package:foodelo/screens/multi_screen_ui_comps/ui_constants.dart';
import 'package:foodelo/general_components/push_error_screen.dart';
// screens
import 'package:foodelo/screens/home_screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const screenId = 'Login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';

  // TODO: Create loading animation when busyLoading is true.
  bool _busyLoading = false;

  NetworkHelper networkHelper = NetworkHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Email TextField
            TextField(
              onChanged: (value) {
                email = value;
              },
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your email',
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),

            // Password textfield
            TextField(
              onChanged: (value) {
                password = value;
              },
              obscureText: true,
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your password',
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),

            // Log in button
            CustomRoundedButton(
              text: 'Log in',
              color: Colors.blueAccent,
              onPressed: () async {
                setState(() {
                  _busyLoading = true;
                });
                try {
                  Map<String, dynamic> responseMap =
                  await networkHelper.loginOnline(email: email, password: password);
                  // TODO: find out why the verification otp is part of the response
                  // If everything went perfectly, the user account has been
                  // created. So, pushReplacement to verification screen.
                  print('Response to the login request $responseMap');
                  if (responseMap['success'] == false) {
                    pushErrorScreen(
                      context: context,
                      error: 'Unhandled error code in: $responseMap',
                      screenId: LoginScreen.screenId,
                    );
                  } else if (responseMap['user']['statusCode'] == 200) {
                    if (mounted) {
                      Navigator.of(context).pushReplacementNamed(HomeScreen.screenId);
                    }
                  }
                } catch (e) {
                  pushErrorScreen(
                    context: context,
                    error: e,
                    screenId: LoginScreen.screenId,
                  );
                }
                setState(() {
                  _busyLoading = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}