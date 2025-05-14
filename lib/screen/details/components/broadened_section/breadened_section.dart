import 'package:flutter/material.dart';
import 'package:medicine_reminder/l10n/locales/l10n.dart';

import '../../../../core/models/medicine.dart';
import '../../../../core/models/medicine_type.dart';
import 'broadened_info_tap.dart';

class BroadenedInfoSection extends StatelessWidget {
  final Medicine medicine;
  const BroadenedInfoSection({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        BroadenedInfoTab(
          fieldTitle: context.l10n.medicineType,
          fieldInfo: medicine.medicineType == MedicineType.none
              ? context.l10n.notSpec
              : "${medicine.medicineType}",
        ),
        BroadenedInfoTab(
          fieldTitle: context.l10n.doseInterval,
          fieldInfo:
          "${context.l10n.every} ${medicine.interval} ${context.l10n.hours} | ${medicine.interval == 24 ? context.l10n.oneTimeADay : "${(24 / medicine.interval!).floor()} ${context.l10n.timesADay}"}",
        ),
        BroadenedInfoTab(
          fieldTitle: context.l10n.startingTime,
          fieldInfo: "${medicine.startTime}",
        ),
      ],
    );
  }
}