import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_reminder/screen/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../core/theme/themes.dart';
import '../settings/settings_notifier.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 2500), (){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route)=>false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = Themes.white;
    final blendColor30 =
    Color.alphaBlend(baseColor.withAlpha(77), Colors.transparent);
    final blendColor10 =
    Color.alphaBlend(baseColor.withAlpha(25), Colors.transparent);
    final borderColor =
    Color.alphaBlend(baseColor.withAlpha(51), Colors.transparent);
    return Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF6A11CB),
                Color(0xFF2575FC),
              ],
            )
          ),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                child: Container(
                  width: 80.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.h),
                    border: Border.all(
                      color: borderColor,
                      width: 1.5
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          blendColor30,
                          blendColor10
                        ])
                  ),
                  child: Lottie.asset(
                    "assets/animations/check_org.json",
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
