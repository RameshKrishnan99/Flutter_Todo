import 'package:flutter/material.dart';

class AppUtils {
  static void showSnackBar(
      {required BuildContext context,
      required String message}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(message),
      ));
  }
}
