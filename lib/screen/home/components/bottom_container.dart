import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../medicine_notifier.dart';
import 'medicine_card.dart';

class BottomContainer extends StatelessWidget {
  const BottomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MedicineNotifier>(
      builder: (context, medicineNotifier, _) {
        if (medicineNotifier.isLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if (medicineNotifier.medicines.isEmpty) {
          return Center(
            child: Text(
              "No Medicine",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          );
        }

        return GridView.builder(
          padding: EdgeInsets.only(top: 1.h),
          itemCount: medicineNotifier.medicines.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 3.w,
              mainAxisSpacing: 3.h
          ),
          itemBuilder: (context, index) {
            final medicine = medicineNotifier.medicines[index];
            return MedicineCard(
              key: ValueKey(medicine.medicineName),
              medicine: medicine,
            );
          },
        );
      },
    );
  }
}