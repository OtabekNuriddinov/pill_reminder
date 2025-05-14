import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AITextField extends StatelessWidget {
  final TextEditingController controller;

  const AITextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.sp,
      ),
      maxLines: null,
      decoration: InputDecoration(
        hintText: 'Ask about your medications...',
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: 16.sp,
        ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      ),
    );
  }
}