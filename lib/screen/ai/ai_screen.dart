import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/components/bottom_nav_bar.dart';
import 'package:medicine_reminder/components/settings_widget.dart';
import 'package:medicine_reminder/core/theme/themes.dart';
import 'package:medicine_reminder/screen/ai/ai_notifier.dart';
import 'package:medicine_reminder/screen/ai/data/gemini_api.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../settings/settings_notifier.dart';
import 'components/ai_text_field.dart';

class AIScreen extends StatefulWidget {
  const AIScreen({super.key});

  @override
  State<AIScreen> createState() => _AIScreenState();
}

class _AIScreenState extends State<AIScreen> {
  final TextEditingController _controller = TextEditingController();
  late Future<String> _apiFuture;

  @override
  void initState() {
    super.initState();
    _apiFuture = GeminiApi.loadApiKey();
  }

  @override
  Widget build(BuildContext context) {
    final aiNotifier = context.watch<AINotifier>();
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
          'AI Assistant',
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(
            fontSize: 18.sp,
            color: Themes.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          SettingsWidget(primaryColor: primaryColor)
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryColor,
              scaffoldColor,
            ],
          ),
        ),
        child: SafeArea(
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: SafeArea(
                child: FutureBuilder<String>(
                  future: _apiFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    }
          
                    final apiKey = snapshot.data!;
                    return Padding(
                      padding: EdgeInsets.all(2.h),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3.h),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                  padding: EdgeInsets.all(3.h),
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
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                          padding: EdgeInsets.only(bottom: 1.h),
                                          itemCount: aiNotifier.messages.length,
                                          itemBuilder: (context, index) {
                                            final message = aiNotifier.messages[index];
                                            final isUser = message['role'] == 'user';
                                            return Align(
                                              alignment: isUser
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                              child: Container(
                                                margin: EdgeInsets.symmetric(vertical: 1.h),
                                                padding: EdgeInsets.all(2.h),
                                                decoration: BoxDecoration(
                                                  color: isUser
                                                      ? Colors.white.withOpacity(0.7)
                                                      : Colors.white.withOpacity(0.4),
                                                  borderRadius: BorderRadius.circular(2.h),
                                                  border: Border.all(
                                                    color: Colors.white.withOpacity(0.2),
                                                    width: 1,
                                                  ),
                                                ),
                                                constraints: BoxConstraints(
                                                  maxWidth: 70.w,
                                                ),
                                                child: Text(
                                                  message['message']!,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.sp,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      if (aiNotifier.isLoading)
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 1.h),
                                          child: LinearProgressIndicator(
                                            backgroundColor: Colors.white.withOpacity(0.2),
                                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                                          ),
                                        ),
                                      SizedBox(height: 1.h),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(2.h),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(2.h),
                                              border: Border.all(
                                                color: Colors.white.withOpacity(0.3),
                                                width: 1.5,
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: AITextField(controller: _controller),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    final text = _controller.text.trim();
                                                    if (text.isNotEmpty &&
                                                        !aiNotifier.isLoading) {
                                                      aiNotifier.sendMessage(text, apiKey);
                                                      _controller.clear();
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.send,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
          settingProvider: settingsProvider,
          selectedIndex: 2
      ),
    );
  }
}