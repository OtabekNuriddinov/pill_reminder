import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../core/theme/colors.dart';
import '../new_entry_notifier.dart';

class IntervalSelection extends StatefulWidget {
  const IntervalSelection({super.key});

  @override
  State<IntervalSelection> createState() => _IntervalSelectionState();
}

class _IntervalSelectionState extends State<IntervalSelection> {
  final _intervals = [6, 8, 12, 24];
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    final NewEntryNotifier newEntry = Provider.of<NewEntryNotifier>(context);
    return Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Remind Me ",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          DropdownButton(
            iconEnabledColor: AppColors.kOtherColor,
            dropdownColor: AppColors.kScaffoldColor,
            itemHeight: 8.h,
            elevation: 4,
            value: _selected == 0 ? null : _selected,
            hint: _selected == 0
                ? Text(
              "Interval Selection",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: AppColors.kPrimaryColor,
                fontSize: 16.sp,
              ),
            )
                : null,
            items: _intervals.map((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(
                  value.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: AppColors.kSecondaryColor),
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selected = newValue!;
                newEntry.updateInterval(newValue);
              });
            },
          ),
          Text(
            _selected == 1 ? "hour" : "hours",
            style: Theme.of(context).textTheme.labelMedium,
          )
        ],
      ),
    );
  }
}