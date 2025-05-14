import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicine_reminder/screen/ai/ai_screen.dart';
import 'package:medicine_reminder/screen/heart_rate/heart_rate_screen.dart';
import 'package:medicine_reminder/screen/home/home_screen.dart';
import 'package:medicine_reminder/screen/news_screen/news_screen.dart';

import '../core/theme/themes.dart';
import '../screen/settings/settings_notifier.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final SettingsNotifier settingProvider;
  final int selectedIndex;
  const BottomNavigationBarWidget({
    required this.settingProvider,
    required this.selectedIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (value){
        if(value==1){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HeartRateScreen()), (route)=>false);
        }
        else if(value == 2){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AIScreen()), (route)=>false);
        }
        else if(value==3){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NewsScreen()), (route)=>false);
        }
        else{
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route)=>false);
        }
      },
      elevation: 0,
      selectedItemColor: Themes.kOtherColor,
      unselectedItemColor: Themes.white,
      type: BottomNavigationBarType.fixed,
      backgroundColor: settingProvider.isDarkMode
          ? Themes.kDarkPrimaryColor
          : Themes.kLightScaffoldColor,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded), label: "Heart"),
        BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.brain), label: 'Assistent'),
        BottomNavigationBarItem(icon: Icon(Icons.article_rounded), label: "News"),
      ],
    );
  }
}