import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_reminder/screen/new_entry/new_entry_notifier.dart';
import 'package:provider/provider.dart';
import 'medicine_notifier.dart';
import 'screen/home/home_screen.dart';
import 'package:sizer/sizer.dart';

import 'core/theme/colors.dart';

class PillReminder extends StatelessWidget {
  const PillReminder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewEntryNotifier()),
        ChangeNotifierProvider(create: (_) => MedicineNotifier()),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Pill Reminder",
            theme: ThemeData.dark().copyWith(
              primaryColor: AppColors.kPrimaryColor,
              scaffoldBackgroundColor: AppColors.kScaffoldColor,
              appBarTheme: AppBarTheme(
                toolbarHeight: 7.h,
                backgroundColor: AppColors.kScaffoldColor,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: AppColors.kSecondaryColor,
                  size: 20.sp,
                ),
                titleTextStyle: GoogleFonts.mulish(
                  color: AppColors.kTextColor,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.normal,
                  fontSize: 16.sp,
                ),
              ),
              textTheme: TextTheme(
                titleMedium:
                TextStyle(fontSize: 20, color: AppColors.kPrimaryColor),
                headlineLarge: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                    color: AppColors.kTextColor),
                headlineMedium: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w900,
                  color: AppColors.kTextColor,
                ),
                labelLarge: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.kSecondaryColor,
                ),
                headlineSmall: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  color: AppColors.kTextColor,
                ),
                labelMedium: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.kTextColor,
                ),
                labelSmall: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.kScaffoldColor,
                ),
              ),
              inputDecorationTheme: const InputDecorationTheme(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.kTextLightColor, width: 0.7)),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.kTextColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.kPrimaryColor))),
              timePickerTheme: TimePickerThemeData(
                backgroundColor: AppColors.kScaffoldColor,
                hourMinuteColor: AppColors.kTextColor,
                hourMinuteTextColor: AppColors.kScaffoldColor,
                dayPeriodColor: AppColors.kTextColor,
                dayPeriodTextColor: AppColors.kPrimaryColor,
                dialBackgroundColor: AppColors.kTextColor,
                dialHandColor: AppColors.kPrimaryColor,
                dialTextColor: AppColors.kScaffoldColor,
                entryModeIconColor: AppColors.kOtherColor,
                dayPeriodTextStyle: GoogleFonts.aBeeZee(
                  fontSize: 16.sp,
                ),
                confirmButtonStyle: ButtonStyle(
                    foregroundColor:
                    WidgetStatePropertyAll(AppColors.kOtherColor)),
                cancelButtonStyle: ButtonStyle(
                  foregroundColor:
                  WidgetStatePropertyAll(AppColors.kSecondaryColor),
                ),
              ),
            ),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
