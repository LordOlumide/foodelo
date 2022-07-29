import 'package:flutter/material.dart';
import 'package:foodelo/network_helper.dart';
// components
import 'package:foodelo/screens/multi_screen_ui_comps/'
    'custom_rounded_button.dart';
import 'package:foodelo/screens/multi_screen_ui_comps/ui_constants.dart';
import 'package:foodelo/general_components/push_error_screen.dart';
// screens
import 'package:foodelo/screens/verify_email_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const screenId = 'Registration_screen';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String name = '';
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
            // Name TextField
            TextField(
              onChanged: (value) {
                name = value;
              },
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your name',
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),

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

            // Register button
            CustomRoundedButton(
              text: 'Register',
              color: Colors.blueAccent,
              onPressed: () async {
                setState(() {
                  _busyLoading = true;
                });
                try {
                  Map<String, dynamic> responseMap =
                      await networkHelper.registerOnline(name: name, email: email, password: password);
                  print('Response to the Registration request: $responseMap');
                  // TODO: find out why the verification otp is part of the response
                  // If everything went perfectly, the user account has been
                  // created. So, pushReplacement to verification screen.
                  if (responseMap['success'] == false) {
                    pushErrorScreen(
                      context: context,
                      error: responseMap['errors'][0]['msg'],
                      screenId: RegistrationScreen.screenId,
                    );
                  } else if (responseMap['user']['statusCode'] == 200) {
                    if (mounted) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => VerifyEmailScreen(passedEmail: email),
                      ));
                    }
                  }
                } catch (e) {
                  pushErrorScreen(
                    context: context,
                    error: e,
                    screenId: RegistrationScreen.screenId,
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
