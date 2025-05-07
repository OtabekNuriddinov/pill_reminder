import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui';

import '../../core/theme/themes.dart';
import '../new_entry/new_entry_screen.dart';
import '../settings/settings_notifier.dart';
import 'components/bottom_container.dart';
import 'components/top_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [primaryColor, scaffoldColor],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.h),
                    child: TopContainer(),
                  ),
                  SizedBox(height: 2.h),
                  Expanded(child: BottomContainer()),
                ],
              ),
            ),
          ),
          floatingActionButton: _buildAddButton(context),
        );
      },
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return InkResponse(
      onTap: () => _navigateToNewEntry(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.h),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            width: 18.w,
            height: 14.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.3),
                  Colors.white.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(5.h),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1.5,
              ),
            ),
            child: Icon(
              Icons.add_outlined,
              color: Colors.white,
              size: 38.0.sp,
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToNewEntry(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NewEntryScreen(),
      ),
    );
  }
}
