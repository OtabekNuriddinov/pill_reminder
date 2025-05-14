import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicine_reminder/screen/settings/settings_notifier.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui';

import '../../../core/models/medicine_type.dart';
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
    final provider = context.watch<SettingsNotifier>();
    return GestureDetector(
      onTap: () {
        newEntryNotifier.updateSelectedMedicine(medicineType);
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(3.h),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                width: 18.w,
                height: 9.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isSelected
                        ? [Colors.white.withOpacity(0.7), Colors.white.withOpacity(0.3)]
                        : [Colors.white.withOpacity(0.2), Colors.white.withOpacity(0.05)],
                  ),
                  borderRadius: BorderRadius.circular(3.h),
                  border: Border.all(
                    color: isSelected
                        ? Colors.white.withOpacity(0.8)
                        : Colors.white.withOpacity(0.2),
                    width: isSelected ? 2.0 : 1.0,
                  ),
                  boxShadow: isSelected
                      ? [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ]
                      : [],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    iconValue,
                    height: 6.h,
                    colorFilter: ColorFilter.mode(
                      isSelected ? Colors.white : Colors.white.withOpacity(0.7),
                      BlendMode.srcIn,
                    ),
                  ),
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
                gradient: isSelected
                    ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white.withOpacity(0.7), Colors.white.withOpacity(0.3)],
                )
                    : null,
                borderRadius: BorderRadius.circular(20),
                border: isSelected
                    ? Border.all(
                  color: Colors.white.withOpacity(0.8),
                  width: 1.0,
                )
                    : null,
              ),
              child: Center(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
                    fontSize: 16.sp,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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