import 'package:flutter/material.dart';
import 'package:medicine_reminder/l10n/locales/l10n.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui';

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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
         Flexible(
           child: Text(
                "${context.l10n.remindMe} ",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
         ),
          SizedBox(width: 2.w),
          ClipRRect(
            borderRadius: BorderRadius.circular(2.h),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.4),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(2.h),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.0,
                  ),
                ),
                child: DropdownButton<int>(
                  underline: Container(),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                  iconEnabledColor: Colors.white,
                  dropdownColor: Theme.of(context).brightness == Brightness.dark
                      ? const Color.fromARGB(180, 31, 31, 31)
                      : const Color.fromARGB(220, 21, 101, 192),
                  itemHeight: 8.h,
                  elevation: 4,
                  value: _selected == 0 ? null : _selected,
                  hint: _selected == 0
                      ? Text(
                    context.l10n.intervalSelection,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                      : null,
                  items: _intervals.map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(
                        value.toString(),
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
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
              ),
            ),
          ),
          SizedBox(width: 2.w),
          Text(
            _selected == 1 ? context.l10n.hour : context.l10n.hours,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
