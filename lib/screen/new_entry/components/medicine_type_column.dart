import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../core/models/medicine_type.dart';
import '../../../core/theme/colors.dart';
import '../new_entry_notifier.dart';

class MedicineTypeColumn extends StatelessWidget {
  final String name;
  final String iconValue;
  final bool isSelected;
  final MedicineType medicineType;

  const MedicineTypeColumn({
    required this.name,
    required this.iconValue,
    required this.isSelected,
    required this.medicineType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final NewEntryNotifier newEntryNotifier = Provider.of<NewEntryNotifier>(context);
    return GestureDetector(
      onTap: () {
        newEntryNotifier.updateSelectedMedicine(medicineType);
      },
      child: Column(
        children: [
          Container(
            width: 18.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.h),
              color: isSelected ? AppColors.kOtherColor : Colors.white,
            ),
            child: Center(
              child: SvgPicture.asset(
                iconValue,
                height: 9.h,
                colorFilter: ColorFilter.mode(
                  isSelected ? Colors.white : AppColors.kOtherColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: Container(
              width: 18.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.kOtherColor : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color:
                    isSelected ? Colors.white : AppColors.kOtherColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}