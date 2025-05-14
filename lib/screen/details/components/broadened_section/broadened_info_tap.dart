import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BroadenedInfoTab extends StatelessWidget {
  final String fieldTitle;
  final String fieldInfo;
  const BroadenedInfoTab({
    super.key,
    required this.fieldTitle,
    required this.fieldInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 0.5.h),
            child: Text(
              fieldTitle,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.white70,
                fontWeight: FontWeight.w500,
                fontSize: 18.sp
              ),
            ),
          ),
          Text(
            fieldInfo,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}