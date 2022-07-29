import 'package:flutter/material.dart';
import 'package:foodelo/network_helper.dart';

// components
import 'package:foodelo/screens/multi_screen_ui_comps/'
    'custom_rounded_button.dart';
import 'package:foodelo/screens/multi_screen_ui_comps/ui_constants.dart';
import 'package:foodelo/general_components/push_error_screen.dart';

// screens
import 'package:foodelo/screens/forgot_password_screen_2.dart';

/// This screen is to request the otp
class ForgotPasswordScreen extends StatefulWidget {
  static const screenId = 'Forgot password screen';

  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String email = '';

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

            // Request OTP button
            CustomRoundedButton(
              text: 'Request OTP',
              color: Colors.blueAccent,
              onPressed: () async {
                setState(() {
                  _busyLoading = true;
                });
                try {
                  Map<String, dynamic> responseMap = await networkHelper
                      .requestPasswordResetOnline(email: email);
                  print('Response to the requestOTP request $responseMap');
                  if (responseMap['user']['statusCode'] == 200) {
                    // At this point, the otp has been requested.
                    // Assign the userId value and push
                    String userId = responseMap['user']['data']['userId'];
                    if (mounted) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>
                              ResetPasswordScreen(userId: userId),
                        ),
                      );
                    }
                  } else {
                    pushErrorScreen(
                      context: context,
                      error: 'Error in response: $responseMap',
                      screenId: ForgotPasswordScreen.screenId,
                    );
                  }
                } catch (e) {
                  pushErrorScreen(
                    context: context,
                    error: e,
                    screenId: ForgotPasswordScreen.screenId,
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
