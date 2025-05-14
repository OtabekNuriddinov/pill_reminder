import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../core/theme/themes.dart';
import '../screen/settings/settings_screen.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({
    super.key,
    required this.primaryColor,
  });

  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 3.w),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Themes.white.withOpacity(0.2),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(2.w),
              child: FaIcon(
                FontAwesomeIcons.gear,
                color: Colors.white,
                size: 5.w,
              ),
            ),
          ),
        )
      ),
    );
  }
}