import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../common/convert_time.dart';
import '../../../core/theme/colors.dart';
import '../new_entry_notifier.dart';

class SelectTime extends StatefulWidget {
  const SelectTime({super.key});

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  late TimeOfDay _time = const TimeOfDay(hour: 0, minute: 00);
  late bool _clicked = false;



  Future<TimeOfDay> _selectTime() async {
    NewEntryNotifier newEntryNotifier = Provider.of<NewEntryNotifier>(context, listen:  false);

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;
        newEntryNotifier.updateTime(convertTime("${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}"));
      });
    }
    return picked!;
  }

  @override
  Widget build(BuildContext context) {
    final NewEntryNotifier newEntryNotifier = Provider.of(context);
    return SizedBox(
      height: 8.h,
      child: Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: AppColors.kPrimaryColor,
              shape: const StadiumBorder()),
          onPressed: () async {
            TimeOfDay picked = await _selectTime();
            String time = "${convertTime(picked.hour.toString())}:${convertTime(picked.minute.toString())}";
            newEntryNotifier.updateTime(time);
                    },
          child: Center(
            child: Text(
              !_clicked
                  ? "Selecting time"
                  : "${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: AppColors.kScaffoldColor),
            ),
          ),
        ),
      ),
    );
  }
}



