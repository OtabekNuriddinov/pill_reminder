import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MainInfoTab extends StatelessWidget {
  final String fieldTitle;
  final String fieldInfo;
  const MainInfoTab(
      {super.key, required this.fieldTitle, required this.fieldInfo});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      height: 10.h,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fieldTitle,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.white70),
            ),
            SizedBox(height: 0.5.h),
            Text(
              fieldInfo,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}