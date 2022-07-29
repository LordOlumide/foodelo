import 'package:flutter/material.dart';
import 'package:foodelo/screens/error_screen.dart';

pushErrorScreen({
  required BuildContext context,
  error,
  required String screenId,
}) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => ErrorScreen(
        error: error.toString(),
        predecessor_id: screenId,
      ),
    ),
  );
}