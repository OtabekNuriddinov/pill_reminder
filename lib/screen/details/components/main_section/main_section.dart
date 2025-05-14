import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicine_reminder/l10n/locales/l10n.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/models/medicine.dart';
import '../../../../core/models/medicine_type.dart';
import 'main_info_tap.dart';

class MainSection extends StatelessWidget {
  final Medicine medicine;
  const MainSection(this.medicine, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        makeIcon(12.h),
        SizedBox(width: 2.w),
        Column(
          children: [
            Hero(
              tag: medicine.medicineName!,
              child: MainInfoTab(
                fieldTitle: context.l10n.medicineName,
                fieldInfo: medicine.medicineName!,
              ),
            ),
            MainInfoTab(
              fieldTitle: context.l10n.dosage,
              fieldInfo: medicine.dosage == 0
                  ? context.l10n.notSpec
                  : "${medicine.dosage} ${context.l10n.msg}",
            )
          ],
        ),
      ],
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
          tag: medicine.medicineName! + (medicine.medicineType ?? ""),
          child: Icon(Icons.error, color: Colors.white, size: size),
        );
    }

    return Hero(
      tag: medicine.medicineName! + (medicine.medicineType ?? ""),
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