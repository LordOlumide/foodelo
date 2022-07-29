import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static const screenId = 'Registration_screen';
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Registration screen'),
      ),
    );
  }
}