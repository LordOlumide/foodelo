import 'package:flutter/material.dart';

// components
import 'package:foodelo/general_components/user_credentials_object.dart';

class HomeScreen extends StatefulWidget {
  static const screenId = 'Home_screen';
  final UserCredentials? userCredentials;

  const HomeScreen({Key? key, this.userCredentials}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(widget.userCredentials.toString()),
      ),
    );
  }
}
