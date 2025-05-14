import 'package:flutter/material.dart';
import 'package:heart_bpm/heart_bpm.dart';
import 'package:just_audio/just_audio.dart';
import 'package:medicine_reminder/components/bottom_nav_bar.dart';
import 'package:medicine_reminder/components/settings_widget.dart';
import 'package:medicine_reminder/core/theme/themes.dart';
import 'package:medicine_reminder/screen/settings/settings_notifier.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HeartRateScreen extends StatefulWidget {
  const HeartRateScreen({super.key});

  @override
  State<HeartRateScreen> createState() => _HeartRateScreenState();
}

class _HeartRateScreenState extends State<HeartRateScreen>
    with TickerProviderStateMixin {
  List<SensorValue> data = [];
  int? bpmValue;
  bool isMeasuring = false;

  final AudioPlayer _audioPlayer = AudioPlayer();

  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _requestPermissions();
    _prepareAudioPlayer();
    _controller =
        AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
  }

  void _requestPermissions() async {
    await [
      Permission.microphone,
      Permission.storage,
    ].request();
  }

  Future<void> _prepareAudioPlayer() async {
    try {
      await _audioPlayer.setAsset('assets/sounds/heart_monitor.mp3');
      print("Audio player prepared successfully");
    } catch (e) {
      print("Error preparing audio player: $e");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void startMeasurement() {
    setState(() {
      bpmValue = null;
      data.clear();
      isMeasuring = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        _playSound();
        Future.delayed(const Duration(seconds: 10), () {
          if (isMeasuring && mounted) {
            _audioPlayer.stop();
            Navigator.of(context).pop();
            setState(() {
              isMeasuring = false;
            });
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                backgroundColor: Themes.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: Text("Timeout", style: TextStyle(
                  fontSize: 18.sp,
                  color: Themes.black
                ),),
                content: Text("Please place your finger on the camera and flashlight, making sure there are no gaps!", style: TextStyle(
                  color: Themes.black,
                  fontSize: 16.sp
                ),),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("OK"),
                  )
                ],
              ),
            );
          }
        });

        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          contentPadding: const EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20.h,
                width: 20.h,
                child: HeartBPMDialog(
                  context: context,
                  onRawData: (value) {
                    setState(() {
                      if (data.length == 100) {
                        data.removeAt(0);
                      }
                      data.add(value);
                    });
                  },
                  onBPM: (value) {
                    if (isMeasuring && value >= 70 && value <= 100) {
                      _audioPlayer.stop();
                      setState(() {
                        bpmValue = value;
                        isMeasuring = false;
                      });
                      Navigator.of(context).pop();

                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          backgroundColor: Themes.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          title: Text(
                            "Result",
                            style: TextStyle(fontSize: 20.sp, color: Themes.black),
                          ),
                          content: Text(
                            "Your heart rate: $bpmValue BPM",
                            style: TextStyle(
                                color: Colors.black, fontSize: 16.sp),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("OK"),
                            )
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 3.h),
              const Text(
                "Measuring...",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2.h),
              const CircularProgressIndicator(strokeWidth: 3),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsNotifier>(builder: (context, provider, __) {
      Color scaffoldColor = provider.isDarkMode
          ? Themes.kDarkScaffoldColor
          : Themes.kLightScaffoldColor;

      Color primaryColor = provider.isDarkMode
          ? Themes.kDarkPrimaryColor
          : Themes.kLightPrimaryColor;

      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Heart Rate",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontSize: 18.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            SettingsWidget(primaryColor: primaryColor)
          ],
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
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: SlideTransition(
                position: _offsetAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(
                        "Cover both the camera and flash with your finger",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                          fontSize: 22.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    ElevatedButton(
                      onPressed: () => startMeasurement(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.1),
                        elevation: 0,
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 2.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side:
                          BorderSide(color: Colors.white.withOpacity(0.3)),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.favorite,
                              color: Colors.red, size: 24),
                          SizedBox(width: 2.w),
                          Text(
                            "Start Measuring",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      bpmValue != null ? "Your BPM: $bpmValue" : "-",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                        fontSize: 22.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBarWidget(
          settingProvider: provider,
          selectedIndex: 1,
        ),
      );
    });
  }
  void _playSound()async{
    try{
      await _audioPlayer.stop();
      await _audioPlayer.setAsset('assets/sounds/heart_monitor.mp3');
      await _audioPlayer.setVolume(1.0);
      _audioPlayer.play();
      print("Audio playback started");
    }
    catch(e){
      print("Error: $e");
    }
  }
}
