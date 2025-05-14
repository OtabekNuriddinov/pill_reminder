import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_reminder/core/theme/app_themes.dart';
import 'package:medicine_reminder/screen/ai/ai_notifier.dart';
import 'package:medicine_reminder/screen/new_entry/new_entry_notifier.dart';
import 'package:medicine_reminder/screen/settings/settings_notifier.dart';
import 'package:medicine_reminder/screen/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'medicine_notifier.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/theme/themes.dart';

class PillReminder extends StatelessWidget {
  const PillReminder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewEntryNotifier()),
        ChangeNotifierProvider(create: (_) => MedicineNotifier()),
        ChangeNotifierProvider(create: (_) => AINotifier()),
        ChangeNotifierProvider(create: (_) => SettingsNotifier())
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return Consumer<SettingsNotifier>(builder: (context, provider, __) {
            if (provider.isLoading) {
              return const MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      color: Themes.kPrimaryColor,
                    ),
                  ),
                ),
              );
            }
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Pill Reminder",
              locale: provider.locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: AppThemes.lightTheme.copyWith(
                scaffoldBackgroundColor: Themes.kLightPrimaryColor,
                appBarTheme: AppBarTheme(
                  toolbarHeight: 7.h,
                  backgroundColor: Themes.kLightScaffoldColor,
                  elevation: 0,
                  iconTheme: IconThemeData(
                    color: Themes.kSecondaryColor,
                    size: 20.sp,
                  ),
                  titleTextStyle: GoogleFonts.mulish(
                    color: Themes.kTextColor,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.normal,
                    fontSize: 16.sp,
                  ),
                ),
                textTheme: TextTheme(
                  titleMedium: TextStyle(
                    fontSize: 16.sp,
                    color: Themes.kPrimaryColor,
                  ),
                  headlineLarge: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                    color: Themes.kOtherColor,
                  ),
                  headlineMedium: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w900,
                    color: Themes.kTextColor,
                  ),
                  labelLarge: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Themes.kSecondaryColor,
                  ),
                  headlineSmall: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    color: Themes.kTextColor,
                  ),
                  titleLarge: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Themes.kTextColor),
                  labelMedium: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Themes.kTextColor,
                  ),
                  labelSmall: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Themes.kDarkScaffoldColor,
                  ),
                ),
                inputDecorationTheme: const InputDecorationTheme(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Themes.kTextLightColor,
                      width: 0.7,
                    ),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Themes.kTextColor,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Themes.kPrimaryColor,
                    ),
                  ),
                ),
                timePickerTheme: TimePickerThemeData(
                  backgroundColor: Themes.kLightScaffoldColor,
                  hourMinuteColor: Themes.kTextColor,
                  hourMinuteTextColor: Themes.kLightScaffoldColor,
                  dayPeriodColor: Themes.kTextColor,
                  dayPeriodTextColor: Themes.kPrimaryColor,
                  dialBackgroundColor: Themes.kTextColor,
                  dialHandColor: Themes.kPrimaryColor,
                  dialTextColor: Themes.kLightScaffoldColor,
                  entryModeIconColor: Themes.kOtherColor,
                  dayPeriodTextStyle: GoogleFonts.aBeeZee(
                    fontSize: 16.sp,
                  ),
                  confirmButtonStyle: const ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(
                      Themes.kOtherColor,
                    ),
                  ),
                  cancelButtonStyle: const ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(
                      Themes.kSecondaryColor,
                    ),
                  ),
                ),
              ),
              darkTheme: AppThemes.darkTheme.copyWith(
                scaffoldBackgroundColor: Themes.black,
                appBarTheme: AppBarTheme(
                  toolbarHeight: 7.h,
                  backgroundColor: Colors.grey.shade900,
                  elevation: 0,
                  iconTheme: IconThemeData(
                    color: Themes.kSecondaryColor,
                    size: 20.sp,
                  ),
                  titleTextStyle: GoogleFonts.mulish(
                    color: Themes.white,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.normal,
                    fontSize: 16.sp,
                  ),
                ),
                textTheme: TextTheme(
                  titleMedium: const TextStyle(
                    fontSize: 20,
                    color: Themes.kPrimaryColor,
                  ),
                  headlineLarge: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                    color: Themes.kOtherColor,
                  ),
                  titleLarge: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Themes.white),
                  headlineMedium: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w900,
                    color: Themes.white,
                  ),
                  labelLarge: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Themes.kSecondaryColor,
                  ),
                  headlineSmall: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    color: Themes.white,
                  ),
                  labelMedium: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Themes.white,
                  ),
                  labelSmall: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Themes.kLightScaffoldColor,
                  ),
                ),
                inputDecorationTheme: const InputDecorationTheme(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Themes.kTextLightColor,
                        width: 0.7,
                      ),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Themes.white,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Themes.kPrimaryColor))),
                timePickerTheme: TimePickerThemeData(
                  backgroundColor: Colors.grey.shade900,
                  hourMinuteColor: Colors.grey.shade800,
                  hourMinuteTextColor: Themes.white,
                  dayPeriodColor: Colors.grey.shade800,
                  dayPeriodTextColor: Themes.kPrimaryColor,
                  dialBackgroundColor: Colors.grey.shade800,
                  dialHandColor: Themes.kPrimaryColor,
                  dialTextColor: Themes.white,
                  entryModeIconColor: Themes.kOtherColor,
                  dayPeriodTextStyle: GoogleFonts.aBeeZee(
                    fontSize: 16.sp,
                  ),
                  confirmButtonStyle: const ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(
                      Themes.kOtherColor,
                    ),
                  ),
                  cancelButtonStyle: const ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(
                      Themes.kSecondaryColor,
                    ),
                  ),
                ),
              ),
              themeMode: provider.themeMode,
              home: const SplashScreen(),
            );
          });
        },
      ),
    );
  }
}
