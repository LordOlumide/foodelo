import 'package:flutter/material.dart';
import 'package:foodelo/network_helper.dart';

// components
import 'package:foodelo/screens/multi_screen_ui_comps/'
    'custom_rounded_button.dart';
import 'package:foodelo/screens/multi_screen_ui_comps/ui_constants.dart';
import 'package:foodelo/general_components/push_error_screen.dart';

/// This screen is to reset the password
class ResetPasswordScreen extends StatefulWidget {
  static const screenId = 'Reset password screen';
  final String userId;

  const ResetPasswordScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String otp = '';
  String newPassword = '';

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
            // OTP TextField
            TextField(
              onChanged: (value) {
                otp = value;
              },
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter OTP',
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),

            // newPassword textfield
            TextField(
              onChanged: (value) {
                newPassword = value;
              },
              obscureText: true,
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter new password',
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),

            // Reset Password button
            CustomRoundedButton(
              text: 'Reset Password',
              color: Colors.blueAccent,
              onPressed: () async {
                setState(() {
                  _busyLoading = true;
                });
                try {
                  Map<String, dynamic> responseMap =
                      await networkHelper.resetPasswordOnline(
                    userId: widget.userId,
                    otp: otp,
                    newPassword: newPassword,
                  );
                  print('Response to the reset password request $responseMap');
                  if (responseMap['user']['statusCode'] == 200) {
                    // At this point, the password has changed so return to welcome screen
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  } else {
                    pushErrorScreen(
                      context: context,
                      error: responseMap['errors'][0]['msg'],
                      screenId: ResetPasswordScreen.screenId,
                    );
                  }
                } catch (e) {
                  pushErrorScreen(
                    context: context,
                    error: e,
                    screenId: ResetPasswordScreen.screenId,
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
