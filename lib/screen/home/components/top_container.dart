import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../medicine_notifier.dart';

class TopContainer extends StatelessWidget {
  const TopContainer({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<MedicineNotifier>(
        builder: (context, notifier, child) {
          if(notifier.isLoading){
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(bottom: 1.h),
                child: Text(
                  "Worry less.\nLive healthier",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(bottom: 1.h),
                child: Text(
                  'Welcome to Daily Dose.',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "${notifier.medicines.length}",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          );
        }
    );
  }
}