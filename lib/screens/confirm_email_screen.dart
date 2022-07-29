import 'package:flutter/material.dart';
import 'package:foodelo/network_helper.dart';
// components
import 'package:foodelo/screens/multi_screen_ui_comps/'
    'custom_rounded_button.dart';
import 'package:foodelo/screens/multi_screen_ui_comps/ui_constants.dart';
import 'package:foodelo/general_components/push_error_screen.dart';
// screens
import 'package:foodelo/screens/home_screen/home_screen.dart';

class ConfirmEmailScreen extends StatefulWidget {
  static const screenId = 'Confirm email screen';
  const ConfirmEmailScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmEmailScreen> createState() => _ConfirmEmailScreenState();
}

class _ConfirmEmailScreenState extends State<ConfirmEmailScreen> {
  String email = '';
  String otp = '';

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

            // Otp TextField
            TextField(
              onChanged: (value) {
                otp = value;
              },
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter the OTP',
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),

            // Register button
            CustomRoundedButton(
              text: 'Verify e-mail',
              color: Colors.blueAccent,
              onPressed: () async {
                setState(() {
                  _busyLoading = true;
                });
                try {
                  Map<String, dynamic> responseMap =
                      await networkHelper.verifyEmail(email: email, otp: otp);
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
                    screenId: ConfirmEmailScreen.screenId,
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
