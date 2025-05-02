import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../core/models/medicine.dart';
import '../../core/models/medicine_type.dart';
import '../../core/theme/colors.dart';
import '../../core/utils/alert_dialog.dart';
import '../../medicine_notifier.dart';

class DetailsScreen extends StatelessWidget {
  final Medicine medicine;
  const DetailsScreen({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    final MedicineNotifier medicineNotifier =
        Provider.of<MedicineNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details",
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(fontSize: 18.sp),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: AppColors.kOtherColor,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 4.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainSection(medicine),
            BroadenedInfoSection(medicine: medicine),
            Spacer(),
            SizedBox(
              width: 100.w,
              height: 7.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.kSecondaryColor,
                    shape: const StadiumBorder()),
                onPressed: () {
                  AppDialog.showMyDialog(
                    context: context,
                    mainText: "Delete Reminder?",
                    leftButText: "cancel",
                    rightButText: "ok",
                    pressLeft: () {
                      Navigator.pop(context);
                    },
                    pressRight: () {
                      int index = medicineNotifier.medicines.indexOf(medicine);
                      medicineNotifier.deleteMedicine(index);
                      Navigator.popUntil(context, ModalRoute.withName("/"));
                    },
                  );
                },
                child: Center(
                  child: Text(
                    "delete",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: AppColors.kScaffoldColor,
                        ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h)
          ],
        ),
      ),
    );
  }
}

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
                fieldTitle: "Medicine Name",
                fieldInfo: medicine.medicineName!,
              ),
            ),
            MainInfoTab(
              fieldTitle:"dosage",
              fieldInfo: medicine.dosage == 0
                  ? "not specific"
                  : "${medicine.dosage} msg",
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
        iconPath = "assets/icons/bottle.svg";
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

class MainInfoTab extends StatelessWidget {
  final String fieldTitle;
  final String fieldInfo;
  const MainInfoTab(
      {super.key, required this.fieldTitle, required this.fieldInfo});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      height: 10.h,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fieldTitle,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.grey),
            ),
            SizedBox(height: 0.3.h),
            Text(
              fieldInfo,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w900),
            )
          ],
        ),
      ),
    );
  }
}

class BroadenedInfoSection extends StatelessWidget {
  final Medicine medicine;
  const BroadenedInfoSection({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        BroadenedInfoTab(
          fieldTitle: "Medicine Type",
          fieldInfo: medicine.medicineType == MedicineType.none
              ? "not specific"
              : "${medicine.medicineType}",
        ),
        BroadenedInfoTab(
          fieldTitle: "dose interval",
          fieldInfo:
              "every ${medicine.interval} hours | ${medicine.interval == 24 ? "oneTimeADay" : "${(24 / medicine.interval!).floor()} times a day"}",
        ),
        BroadenedInfoTab(
          fieldTitle: "Starting time",
          fieldInfo: "${medicine.startTime}",
        ),
      ],
    );
  }
}

class BroadenedInfoTab extends StatelessWidget {
  final String fieldTitle;
  final String fieldInfo;
  const BroadenedInfoTab({
    super.key,
    required this.fieldTitle,
    required this.fieldInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: SizedBox(
        width: 40.w,
        height: 10.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 1.h),
              child: Text(
                fieldTitle,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            Text(
              fieldInfo,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: AppColors.kSecondaryColor),
            )
          ],
        ),
      ),
    );
  }
}
