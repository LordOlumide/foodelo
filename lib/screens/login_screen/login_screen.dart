import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const screenId = 'Login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Login screen'),
      ),
    );
  }
}