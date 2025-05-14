import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AboutAppCard extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  final IconData icon;

  const AboutAppCard({
    required this.title,
    required this.onPressed,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(3.h),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.3),
                Colors.white.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(3.h),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: ListTile(
            leading: Icon(
              icon,
              color: Colors.white,
            ),
            title: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 16,
            ),
            onTap: onPressed,
          ),
        ),
      ),
    );
  }
}