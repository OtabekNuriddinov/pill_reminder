import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class PanelTitle extends StatelessWidget {
  final String title;
  final bool isRequired;
  const PanelTitle({
    super.key,
    required this.title,
    required this.isRequired,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: title,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 17.sp,
              ),
            ),
            TextSpan(
              text: isRequired ? " *" : "",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.amber.shade300,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}