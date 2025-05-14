import 'package:flutter/material.dart';
import 'package:medicine_reminder/screen/settings/settings_notifier.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../core/theme/themes.dart';

class NewsDetail extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;
  const NewsDetail({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {



  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsNotifier>(
      builder: (context, provider, __) {
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
              "Detail",
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
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Hero(
                      tag: widget.imageUrl,
                      child: Image.network(
                        widget.imageUrl,
                        width: double.infinity,
                        height: 35.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey,
                            child: Icon(Icons.broken_image, size: 30.sp),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 3.h),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.w),
                      child: Text(
                        widget.description,
                        style: TextStyle(fontSize: 18.sp, color: Themes.white),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
