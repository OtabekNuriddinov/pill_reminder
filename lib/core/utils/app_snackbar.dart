import 'package:flutter/material.dart';
import '../theme/themes.dart';

sealed class AppSnackbar {
  static void msg(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          backgroundColor: Themes.kOtherColor,
        ),
      );
  }
}