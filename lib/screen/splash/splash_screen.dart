import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:medicine_reminder/core/theme/themes.dart';
import 'package:medicine_reminder/screen/home/home_screen.dart';
import 'package:medicine_reminder/screen/settings/settings_notifier.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsNotifier>(
        builder: (context, settingsProvider, child) {
      Color scaffoldColor = settingsProvider.isDarkMode
          ? Themes.kDarkScaffoldColor
          : Themes.kLightScaffoldColor;
      Color primaryColor = settingsProvider.isDarkMode
          ? Themes.kDarkPrimaryColor
          : Themes.kLightPrimaryColor;
      final baseColor = Themes.white;
      final blendColor30 = baseColor.withOpacity(0.3);
      final blendColor10 = baseColor.withOpacity(0.1);
      final borderColor = baseColor.withOpacity(0.2);
      return Scaffold(
        body: Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primaryColor, scaffoldColor],
            ),
          ),
          child: Center(
            child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, ch) {
                  return FadeTransition(
                    opacity: _opacityAnimation,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.h),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                        child: Container(
                          width: 80.w,
                          height: 40.h,
                          padding: EdgeInsets.all(2.h),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [blendColor30, blendColor10],
                            ),
                            borderRadius: BorderRadius.circular(5.h),
                            border: Border.all(
                              color: borderColor,
                              width: 1.5,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                height: 36.h,
                                child: Image.asset(
                                  "assets/images/splash_image.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                bottom: 3.h,
                                child: Text(
                                  "PILL REMINDER",
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Themes.white,
                                      letterSpacing: 1.5),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      );
    });
  }
}
