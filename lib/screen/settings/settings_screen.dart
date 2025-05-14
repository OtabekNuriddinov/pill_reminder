import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/l10n/locales/l10n.dart';
import 'package:medicine_reminder/screen/settings/settings_notifier.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../core/theme/themes.dart';
import 'components/about_app_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedLanguage = "English";
  final List<String> _languages = ['Uzbek', 'Russian', 'English'];

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<SettingsNotifier>(context, listen: false);
    switch (provider.locale.languageCode) {
      case 'uz':
        _selectedLanguage = "Uzbek";
        break;
      case 'ru':
        _selectedLanguage = "Russian";
        break;
      case 'en':
        _selectedLanguage = "English";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsNotifier>();

    Color scaffoldColor = settingsProvider.isDarkMode
        ? Themes.kDarkScaffoldColor
        : Themes.kLightScaffoldColor;

    Color primaryColor = settingsProvider.isDarkMode
        ? Themes.kDarkPrimaryColor
        : Themes.kLightPrimaryColor;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          context.l10n.settings,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontSize: 18.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [primaryColor, scaffoldColor],
          ),
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(2.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Appearance Section
                      Padding(
                        padding: EdgeInsets.only(left: 2.w, bottom: 1.h),
                        child: Text(
                          context.l10n.appearance,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      // Language Card
                      _buildGlassmorphicCard(
                        child: ExpansionTile(
                          iconColor: Colors.white,
                          collapsedIconColor: Colors.white,
                          title: Text(
                            context.l10n.language,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          children: _languages.map((lang) {
                            return ListTile(
                              title: Text(
                                lang,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                ),
                              ),
                              trailing: _selectedLanguage == lang
                                  ? const Icon(Icons.check, color: Colors.white)
                                  : null,
                              onTap: () {
                                setState(() {
                                  _selectedLanguage = lang;
                                });
                                final provider = Provider.of<SettingsNotifier>(context, listen: false);
                                switch (lang) {
                                  case 'Uzbek':
                                    provider.setLanguage('uz');
                                    break;
                                  case 'Russian':
                                    provider.setLanguage('ru');
                                    break;
                                  case 'English':
                                    provider.setLanguage('en');
                                    break;
                                }
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      // Theme Mode Card
                      _buildGlassmorphicCard(
                        child: Consumer<SettingsNotifier>(
                          builder: (context, provider, __) {
                            return ListTile(
                              leading: Icon(
                                provider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                                color: Colors.white,
                              ),
                              title: Text(
                                provider.isDarkMode ? context.l10n.dark : context.l10n.light,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: Switch(
                                activeColor: Colors.white,
                                activeTrackColor: Colors.white.withOpacity(0.5),
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: Colors.white.withOpacity(0.3),
                                value: provider.isDarkMode,
                                onChanged: (val) {
                                  provider.toggleTheme();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 2.h),
                      _buildGlassmorphicCard(
                        child: Consumer<SettingsNotifier>(
                          builder: (context, provider, _) {
                            return ListTile(
                              leading: const Icon(Icons.battery_saver, color: Colors.white),
                              title: Text(
                                "Battery Saver",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: Switch(
                                activeColor: Colors.white,
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: Colors.white.withOpacity(0.3),
                                value: provider.isBatterySaver,
                                onChanged: (val) {
                                  provider.toggleBatterySaver();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.only(left: 2.w, bottom: 1.h),
                        child: Text(
                          "Notifications",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      // Notifications Toggle
                      _buildGlassmorphicCard(
                        child: Consumer<SettingsNotifier>(
                          builder: (context, provider, _) {
                            return ListTile(
                              leading: const Icon(Icons.notifications_active_outlined, color: Colors.white),
                              title: Text(
                                "Show notification",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: Switch(
                                activeColor: Colors.white,
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: Colors.white.withOpacity(0.3),
                                value: provider.isNotificationEnabled,
                                onChanged: (val) {
                                  provider.toggleNotification();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 2.h),
                      _buildGlassmorphicCard(
                        child: Consumer<SettingsNotifier>(
                          builder: (context, provider, _) {
                            List<String> sounds = ['Default', 'Chime', 'Bell', 'Whistle'];
                            return ExpansionTile(
                              iconColor: Colors.white,
                              collapsedIconColor: Colors.white,
                              title: Text(
                                "Notification Sound",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              children: sounds.map((sound) {
                                return ListTile(
                                  title: Text(
                                    sound,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  trailing: provider.selectedNotificationSound == sound
                                      ? const Icon(Icons.check, color: Colors.white)
                                      : null,
                                  onTap: () {
                                    provider.setNotificationSound(sound);
                                  },
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.only(left: 2.w, bottom: 1.h),
                        child: Text(
                          context.l10n.aboutApp,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      _buildGlassmorphicCard(
                        child: ListTile(
                          leading: const Icon(Icons.info_outline, color: Colors.white),
                          title: Text(
                            context.l10n.appVersion,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            "v1.0.0",
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 1.5.h),
                      // Privacy Card
                      AboutAppCard(
                        title: context.l10n.privacy,
                        icon: Icons.privacy_tip_outlined,
                        onPressed: () {},
                      ),
                      SizedBox(height: 1.5.h),
                      // Terms of Use Card
                      AboutAppCard(
                        title: context.l10n.termsOfUse,
                        icon: Icons.description_outlined,
                        onPressed: () {},
                      ),
                      SizedBox(height: 1.5.h),
                      // Contact Us Card
                      AboutAppCard(
                        title: context.l10n.contactUs,
                        icon: Icons.email_outlined,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassmorphicCard({required Widget child}) {
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
          child: child,
        ),
      ),
    );
  }
}
