import 'package:flutter/material.dart';
import 'package:foodelo/network_helper.dart';
// components
import 'package:foodelo/screens/multi_screen_ui_comps/'
    'custom_rounded_button.dart';
import 'package:foodelo/screens/multi_screen_ui_comps/ui_constants.dart';
import 'package:foodelo/general_components/push_error_screen.dart';
// screens
import 'package:foodelo/screens/login_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  static const screenId = 'Verify email screen';

  String? passedEmail;
  VerifyEmailScreen({Key? key, this.passedEmail}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  String email = '';
  String otp = '';

  // Create a TextEditingController to set the initial value of the email textfield
  late TextEditingController emailFieldController;

  // TODO: Create loading animation when busyLoading is true.
  bool _busyLoading = false;

  NetworkHelper networkHelper = NetworkHelper();

  @override
  void initState() {
    super.initState();
    // To set the initial value of the email TextField
    email = widget.passedEmail ?? '';
    emailFieldController = TextEditingController(text: email);
  }

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
              controller: emailFieldController,
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

            // Otp TextField
            TextField(
              onChanged: (value) {
                otp = value;
              },
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter the OTP',
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),

            // Verify button
            CustomRoundedButton(
              text: 'Verify e-mail',
              color: Colors.blueAccent,
              onPressed: () async {
                setState(() {
                  _busyLoading = true;
                });
                try {
                  Map<String, dynamic> responseMap =
                      await networkHelper.verifyEmailOnline(email: email, otp: otp);
                  // If everything went perfectly, the email is verified.
                  // So, pushReplacement to HomeScreen
                  print('The response to the VerifyEmail request: $responseMap');
                  if (responseMap['user']['statusCode'] == 200) {
                    networkHelper.verifyEmailOnline(email: email, otp: otp);
                    if (mounted) {
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.screenId);
                    }
                  } else if (responseMap['user']['statusCode'] != 200) {
                    pushErrorScreen(
                      context: context,
                      error: responseMap['user']['message'],
                      screenId: VerifyEmailScreen.screenId,
                    );
                  }
                } catch (e) {
                  pushErrorScreen(
                    context: context,
                    error: e,
                    screenId: VerifyEmailScreen.screenId,
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

  @override
  void dispose() {
    super.dispose();
    // dispose the TextEditingController
    emailFieldController.dispose();
  }

}
