import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/l10n/locales/l10n.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../common/convert_time.dart';
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
    final newEntryNotifier = Provider.of<NewEntryNotifier>(context, listen: false);

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;
        newEntryNotifier.updateTime(
            convertTime("${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}")
        );
      });
    }

    return picked!;
  }

  @override
  Widget build(BuildContext context) {
    final newEntryNotifier = Provider.of<NewEntryNotifier>(context);

    return SizedBox(
      height: 8.h,
      child: Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () async {
            TimeOfDay picked = await _selectTime();
            String time = "${convertTime(picked.hour.toString())}:${convertTime(picked.minute.toString())}";
            newEntryNotifier.updateTime(time);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                height: 7.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.25),
                      Colors.white.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Center(
                  child: Text(
                    !_clicked
                        ? context.l10n.selectTime
                        : "${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
