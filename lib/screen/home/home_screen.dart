import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/theme/colors.dart';
import '../new_entry/new_entry_screen.dart';
import 'components/bottom_container.dart';
import 'components/top_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h),
                child: TopContainer(),
              ),
              SizedBox(height: 2.h),
              Expanded(child: BottomContainer()),
            ],
          ),
        ),
      floatingActionButton: _buildAddButton(context),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return InkResponse(
      onTap: () => _navigateToNewEntry(context),
      child: SizedBox(
        width: 18.w,
        height: 14.h,
        child: Card(
          color: AppColors.kPrimaryColor,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(5.h),
          ),
          child: Icon(
            Icons.add_outlined,
            color: AppColors.kScaffoldColor,
            size: 38.0.sp,
          ),
        ),
      ),
    );
  }

  void _navigateToNewEntry(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NewEntryScreen(),
      ),
    );
  }
}
