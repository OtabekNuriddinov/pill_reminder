import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/l10n/locales/l10n.dart';
import 'package:medicine_reminder/screen/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/models/medicine.dart';
import '../../medicine_notifier.dart';
import '../settings/settings_screen.dart';
import 'components/broadened_section/breadened_section.dart';
import 'components/main_section/main_section.dart';

class DetailsScreen extends StatelessWidget {
  final Medicine medicine;
  const DetailsScreen({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    final MedicineNotifier medicineNotifier =
        Provider.of<MedicineNotifier>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          context.l10n.details,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 18.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 3.w),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  );
                },
                icon: FaIcon(FontAwesomeIcons.gear, color: Colors.white),
              ),
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6A11CB),
              Color(0xFF2575FC),
            ],
          ),
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Section with Medicine Name and Dosage
                    ClipRRect(
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
                          child: MainSection(medicine),
                        ),
                      ),
                    ),

                    SizedBox(height: 2.h),

                    // Broadened Info Section
                    ClipRRect(
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
                          child: BroadenedInfoSection(medicine: medicine),
                        ),
                      ),
                    ),

                    Spacer(),

                    // Delete Button
                    Padding(
                      padding: EdgeInsets.only(
                        left: 8.w,
                        right: 8.w,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5.h),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: SizedBox(
                            width: 80.w,
                            height: 8.h,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.3),
                                shape: StadiumBorder(
                                  side: BorderSide(
                                    color: Colors.white.withOpacity(0.5),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                showDeleteDialog(context, medicineNotifier);
                              },
                              child: Center(
                                child: Text(
                                  context.l10n.delete,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showDeleteDialog(
      BuildContext context, MedicineNotifier medicineNotifier) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2.h),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: EdgeInsets.all(3.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.4),
                        Colors.white.withOpacity(0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2.h),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${context.l10n.deleteReminder}?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.3),
                              shape: StadiumBorder(
                                side: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                  width: 1.5,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.w, vertical: 1.h),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              context.l10n.cancel,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.red.withOpacity(0.3),
                              shape: StadiumBorder(
                                side: BorderSide(
                                  color: Colors.red.withOpacity(0.5),
                                  width: 1.5,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.w, vertical: 1.h),
                            ),
                            onPressed: () {
                              int index =
                                  medicineNotifier.medicines.indexOf(medicine);
                              medicineNotifier.deleteMedicine(index);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                (route) => false,
                              );
                            },
                            child: Text(
                              context.l10n.ok,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
