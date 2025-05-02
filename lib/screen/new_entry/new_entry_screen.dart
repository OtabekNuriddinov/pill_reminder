import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../core/models/errors.dart';
import '../../core/models/medicine.dart';
import '../../core/models/medicine_type.dart';
import '../../core/utils/app_snackbar.dart';
import '../../medicine_notifier.dart';
import '../ai/presentation/ai_screen.dart';
import '../success/sucess_screen.dart';
import '/core/theme/colors.dart';
import 'package:sizer/sizer.dart';

import 'components/interval_selection.dart';
import 'components/medicine_type_column.dart';
import 'components/panel_title.dart';
import 'components/select_time.dart';
import 'new_entry_notifier.dart';

class NewEntryScreen extends StatefulWidget {
  const NewEntryScreen({super.key});

  @override
  State<NewEntryScreen> createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  late TextEditingController nameController;
  late TextEditingController dosageController;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    dosageController = TextEditingController();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    dosageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Add New",
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(fontSize: 18.sp),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: AppColors.kOtherColor,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AIScreen(),
                  ),
                );
              },
              icon: FaIcon(FontAwesomeIcons.brain)),
          IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.gear))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PanelTitle(
              title: "Medicine Name",
              isRequired: true,
            ),
            TextFormField(
              controller: nameController,
              maxLength: 12,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: AppColors.kOtherColor),
            ),
            PanelTitle(
              title: "Dosage in msg",
              isRequired: false,
            ),
            TextFormField(
              controller: dosageController,
              maxLength: 12,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
              ),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: AppColors.kOtherColor),
            ),
            SizedBox(height: 2.h),
            PanelTitle(
              title: "Medicine Type",
              isRequired: false,
            ),
            Padding(
              padding: EdgeInsets.only(top: 1.h),
              child: Consumer<NewEntryNotifier>(
                builder: (context, newEntryNotifier, __) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MedicineTypeColumn(
                          medicineType: MedicineType.bottle,
                          name: "Bottle",
                          iconValue: "assets/icons/pill_bottle.svg",
                          isSelected: newEntryNotifier.selectedMedicineType ==
                              MedicineType.bottle),
                      MedicineTypeColumn(
                          medicineType: MedicineType.pill,
                          name: "Pill",
                          iconValue: "assets/icons/pill.svg",
                          isSelected: newEntryNotifier.selectedMedicineType ==
                              MedicineType.pill),
                      MedicineTypeColumn(
                          medicineType: MedicineType.syringe,
                          name: "Syringe",
                          iconValue: "assets/icons/syringe.svg",
                          isSelected: newEntryNotifier.selectedMedicineType ==
                              MedicineType.syringe),
                      MedicineTypeColumn(
                          medicineType: MedicineType.tablet,
                          name: "Tablet",
                          iconValue: "assets/icons/tablet.svg",
                          isSelected: newEntryNotifier.selectedMedicineType ==
                              MedicineType.tablet),
                    ],
                  );
                },
              ),
            ),
            PanelTitle(
              title: "Interval selection",
              isRequired: true,
            ),
            IntervalSelection(),
            PanelTitle(
              title: "Starting time",
              isRequired: true,
            ),
            const SelectTime(),
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.only(
                left: 8.w,
                right: 8.w,
              ),
              child: SizedBox(
                width: 80.w,
                height: 8.h,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.kPrimaryColor,
                    shape: StadiumBorder(),
                  ),
                  onPressed: () {
                    /// Adding
                    final medicineName = nameController.text;
                    final dosage = dosageController.text;

                    final newEntry =
                        Provider.of<NewEntryNotifier>(context, listen: false);
                    final medicineProvider =
                        Provider.of<MedicineNotifier>(context, listen: false);

                    if (medicineName.trim().isEmpty || dosage.trim().isEmpty) {
                      newEntry.submitError(EntryErrors.emptyFields);
                      AppSnackbar.msg(context, "Please fill all the gaps!");
                      return;
                    }

                    for (var medicine in medicineProvider.medicines) {
                      if (medicineName == medicine.medicineName) {
                        newEntry.submitError(EntryErrors.nameDuplicate);
                        AppSnackbar.msg(
                            context, "This medicine already exists!");
                        return;
                      }
                    }

                    if (newEntry.selectedInterval == 0) {
                      newEntry.submitError(EntryErrors.interval);
                      AppSnackbar.msg(context, "Please select interval!");
                      return;
                    }

                    if (newEntry.selectedTimeOfDay == null ||
                        newEntry.selectedTimeOfDay == "None") {
                      AppSnackbar.msg(
                          context, "Please select Starting time!");
                      return;
                    }

                    String medicineType =
                        newEntry.selectedMedicineType.toString().substring(13);

                    int interval = newEntry.selectedInterval;
                    String startTime = newEntry.selectedTimeOfDay!;

                    List<int> intIDs = makeIDs(24 / newEntry.selectedInterval);

                    List<String> notificationIDs =
                        intIDs.map((i) => i.toString()).toList();

                    Medicine newMedicine = Medicine(
                      notificationIDs: notificationIDs,
                      medicineName: medicineName,
                      dosage: dosage,
                      medicineType: medicineType,
                      interval: interval,
                      startTime: startTime,
                    );
                    medicineProvider.addMedicine(newMedicine);

                    nameController.clear();
                    dosageController.clear();
                    newEntry.reset();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuccessScreen(),
                      ),
                    );
                  },
                  child: Center(
                    child: Text(
                      "Confirm",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: AppColors.kScaffoldColor),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<int> makeIDs(double n) {
    var rand = Random();
    List<int> ids = [];
    for (int i = 0; i < n; i++) {
      ids.add(rand.nextInt(10000000));
    }
    return ids;
  }
}
