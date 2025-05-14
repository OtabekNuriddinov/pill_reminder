import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicine_reminder/screen/settings/settings_notifier.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui';

import '../../../core/models/medicine.dart';
import '../../../core/models/medicine_type.dart';
import '../../details/details_screen.dart';

class MedicineCard extends StatelessWidget {
  final Medicine medicine;
  const MedicineCard({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SettingsNotifier>();
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(2.h),
        highlightColor: Colors.white.withOpacity(0.1),
        splashColor: Colors.white.withOpacity(0.2),
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: animation.value,
                      child: DetailsScreen(medicine: medicine),
                    );
                  },
                );
              },
              transitionDuration: const Duration(milliseconds: 500),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(2.h),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              width: 16.w,
              height: 16.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(2.h),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 0.5,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Center(child: makeIcon(7.h)),
                    const Spacer(),
                    Hero(
                      tag: medicine.medicineName ?? 'unknown_medicine',
                      child: Text(
                        medicine.medicineName ?? 'Unknown',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 0.3.h),
                    Text(
                      medicine.dosage ?? "1",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14.sp),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Hero makeIcon(double size) {
    final type = MedicineTypeExtension.fromString(medicine.medicineType ?? "");
    String iconPath;
    switch (type) {
      case MedicineType.bottle:
        iconPath = "assets/icons/syrup1.svg";
        break;
      case MedicineType.pill:
        iconPath = "assets/icons/pill.svg";
        break;
      case MedicineType.syringe:
        iconPath = "assets/icons/syringe.svg";
        break;
      case MedicineType.tablet:
        iconPath = "assets/icons/tablet.svg";
        break;
      default:
        return Hero(
          tag: (medicine.medicineName ?? "unknown") + (medicine.medicineType ?? ""),
          child: Icon(Icons.error, color: Colors.white, size: size),
        );
    }

    return Hero(
      tag: (medicine.medicineName ?? 'unknown') + (medicine.medicineType ?? ""),
      child: SvgPicture.asset(
        iconPath,
        height: size,
        colorFilter: const ColorFilter.mode(
          Colors.white,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}