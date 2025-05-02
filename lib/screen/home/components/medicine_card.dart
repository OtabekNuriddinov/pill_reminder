import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/models/medicine.dart';
import '../../../core/models/medicine_type.dart';
import '../../../core/theme/colors.dart';
import '../../details/details_screen.dart';

class MedicineCard extends StatelessWidget {
  final Medicine medicine;
  const MedicineCard({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(2.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(2.h),
        highlightColor: Colors.white,
        splashColor: Colors.grey,
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
        child: Container(
          width: 16.w,
          height: 16.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2.h),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                makeIcon(7.h),
                const Spacer(),
                Hero(
                  tag: medicine.medicineName!,
                  child: Text(
                    medicine.medicineName!,
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontSize: 18),
                  ),
                ),
                SizedBox(height: 0.3.h),
                Text(
                  medicine.dosage ?? "1",
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColors.kTextLightColor, fontSize: 14.sp),
                )
              ],
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
        iconPath = "assets/icons/pill_bottle.svg";
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
          tag: medicine.medicineName! + (medicine.medicineType ?? ""),
          child: Icon(Icons.error, color: AppColors.kPrimaryColor, size: size),
        );
    }

    return Hero(
      tag: medicine.medicineName! + (medicine.medicineType ?? ""),
      child: SvgPicture.asset(
        iconPath,
        height: size,
        colorFilter: ColorFilter.mode(
          AppColors.kPrimaryColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
