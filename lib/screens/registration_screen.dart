import 'package:flutter/material.dart';
import 'package:foodelo/network_helper.dart';

// components
import 'package:foodelo/screens/multi_screen_ui_comps/'
    'custom_rounded_button.dart';
import 'package:foodelo/screens/multi_screen_ui_comps/ui_constants.dart';
import 'package:foodelo/general_components/push_error_screen.dart';

// screens
import 'package:foodelo/screens/confirm_email_screen.dart';

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
                      await networkHelper.register(name, email, password);
                  if (responseMap['user']['statusCode'] == 200) {
                    print(responseMap['user']['data']['email']);
                  }

                  // // If everything went perfectly
                  // if (response['statusCode'] == 200) {
                  //
                  // }
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
