import 'package:flutter/material.dart';

import '../theme/themes.dart';

sealed class AppDialog {
  static Future<dynamic> showMyDialog({
    required BuildContext context,
    required String mainText,
    required leftButText,
    required rightButText,
    required void Function() pressLeft,
    required void Function() pressRight,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Themes.kLightScaffoldColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0))),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(mainText, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            actions: <Widget>[
              Row(
                children: [
                  Expanded(
                      child: TextButton(
                    onPressed: pressLeft,
                    child: Text(
                      leftButText,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Themes.kTextLightColor),
                    ),
                  )),
                  SizedBox(width: 5),
                  Expanded(
                      child: TextButton(
                    onPressed: pressRight,
                    child: Text(
                      rightButText,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: Themes.kSecondaryColor),
                    ),
                  )),
                ],
              )
            ],
          );
        });
  }
}
