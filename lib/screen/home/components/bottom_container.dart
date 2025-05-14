import 'package:flutter/material.dart';
import 'package:medicine_reminder/l10n/locales/l10n.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui';

import '../../../medicine_notifier.dart';
import 'medicine_card.dart';

class BottomContainer extends StatefulWidget {
  const BottomContainer({super.key});

  @override
  State<BottomContainer> createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer> {

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<MedicineNotifier>(
      builder: (context, medicineNotifier, _) {
        if (medicineNotifier.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        }

        if (medicineNotifier.medicines.isEmpty) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.h),
              topRight: Radius.circular(4.h),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.15),
                      Colors.white.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.h),
                    topRight: Radius.circular(4.h),
                  ),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.medical_services_outlined,
                        size: 15.w,
                        color: Colors.white.withOpacity(0.7),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        context.l10n.noMedicine,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.h),
            topRight: Radius.circular(4.h),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.15),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.h),
                  topRight: Radius.circular(4.h),
                ),
                border: Border(
                  top: BorderSide(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.5,
                  ),
                  left: BorderSide(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.5,
                  ),
                  right: BorderSide(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.5,
                  ),
                ),
              ),
              child: GridView.builder(
                padding: EdgeInsets.only(top: 3.h, right: 3.w, left: 3.w, bottom: 2.h),
                itemCount: medicineNotifier.medicines.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 3.w,
                  mainAxisSpacing: 3.h,
                ),
                itemBuilder: (context, index) {
                  final medicine = medicineNotifier.medicines[index];
                  return MedicineCard(
                    key: ValueKey(medicine.medicineName),
                    medicine: medicine,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}