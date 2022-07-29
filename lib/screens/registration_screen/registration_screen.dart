import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
// components
import 'package:foodelo/screens/multi_screen_ui_comps/'
    'custom_rounded_button.dart';
import 'package:foodelo/screens/multi_screen_ui_comps/ui_constants.dart';
import 'package:foodelo/general_components/push_error_screen.dart';
// screens
import 'package:foodelo/screens/home_screen/home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const screenId = 'Registration_screen';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  String email = '';
  String password = '';
  bool _busyLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _busyLoading,
        child: Padding(
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

              // Register button
              CustomRoundedButton(
                text: 'Register',
                color: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    _busyLoading = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, HomeScreen.screenId);
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
      ),
    );
  }
}
