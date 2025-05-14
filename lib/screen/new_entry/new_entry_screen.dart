import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/l10n/locales/l10n.dart';
import 'package:medicine_reminder/screen/settings/settings_notifier.dart';
import 'package:provider/provider.dart';
import '../../components/settings_widget.dart';
import '../../core/models/errors.dart';
import '../../core/models/medicine.dart';
import '../../core/models/medicine_type.dart';
import '../../core/utils/app_snackbar.dart';
import '../../medicine_notifier.dart';
import '../success/sucess_screen.dart';
import '/core/theme/themes.dart';
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
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    dosageController = TextEditingController();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  void dispose() {
    nameController.dispose();
    dosageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsNotifier>(
      builder: (context, settingsProvider, child) {
        Color scaffoldColor = settingsProvider.isDarkMode
            ? Themes.kDarkScaffoldColor
            : Themes.kLightScaffoldColor;

        Color primaryColor = settingsProvider.isDarkMode
            ? Themes.kDarkPrimaryColor
            : Themes.kLightPrimaryColor;

        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: scaffoldColor,
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              context.l10n.addNew,
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 18.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              SettingsWidget(primaryColor: primaryColor)
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [primaryColor, scaffoldColor],
              ),
            ),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(2.h),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildGlassCard(
                            context,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PanelTitle(
                                  title: context.l10n.medicineName,
                                  isRequired: true,
                                ),
                                TextFormField(
                                  controller: nameController,
                                  maxLength: 12,
                                  textCapitalization: TextCapitalization.words,
                                  decoration: _inputDecoration(),
                                  style: _textStyle(context),
                                ),
                                PanelTitle(
                                  title: context.l10n.dosageInMsg,
                                  isRequired: false,
                                ),
                                TextFormField(
                                  controller: dosageController,
                                  maxLength: 12,
                                  keyboardType: TextInputType.number,
                                  decoration: _inputDecoration(),
                                  style: _textStyle(context),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.h),
                          _buildGlassCard(
                            context,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PanelTitle(
                                  title: context.l10n.medicineType,
                                  isRequired: false,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 1.h),
                                  child: Consumer<NewEntryNotifier>(
                                    builder: (context, newEntryNotifier, __) {
                                      return Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          MedicineTypeColumn(
                                              medicineType: MedicineType.bottle,
                                              name: "Syrup",
                                              iconValue:
                                              "assets/icons/syrup1.svg",
                                              isSelected:
                                              newEntryNotifier.selectedMedicineType ==
                                                  MedicineType.bottle),
                                          MedicineTypeColumn(
                                              medicineType: MedicineType.pill,
                                              name: context.l10n.pill,
                                              iconValue: "assets/icons/pill.svg",
                                              isSelected:
                                              newEntryNotifier.selectedMedicineType ==
                                                  MedicineType.pill),
                                          MedicineTypeColumn(
                                              medicineType: MedicineType.syringe,
                                              name: context.l10n.syringe,
                                              iconValue:
                                              "assets/icons/syringe.svg",
                                              isSelected:
                                              newEntryNotifier.selectedMedicineType ==
                                                  MedicineType.syringe),
                                          MedicineTypeColumn(
                                              medicineType: MedicineType.tablet,
                                              name: context.l10n.tablet,
                                              iconValue:
                                              "assets/icons/tablet.svg",
                                              isSelected:
                                              newEntryNotifier.selectedMedicineType ==
                                                  MedicineType.tablet),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.h),
                          _buildGlassCard(
                            context,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PanelTitle(
                                  title: context.l10n.intervalSelection,
                                  isRequired: true,
                                ),
                                const IntervalSelection(),
                                PanelTitle(
                                  title: context.l10n.startingTime,
                                  isRequired: true,
                                ),
                                const SelectTime(),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.h),
                              child: BackdropFilter(
                                filter:
                                ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                child: SizedBox(
                                  width: 80.w,
                                  height: 8.h,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                      primaryColor.withOpacity(0.3),
                                      shape: StadiumBorder(
                                        side: BorderSide(
                                          color: Colors.white.withOpacity(0.5),
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    onPressed: () async{
                                      final medicineName =
                                      nameController.text.trim();
                                      final dosage =
                                      dosageController.text.trim();
                                      final newEntry =
                                      Provider.of<NewEntryNotifier>(context,
                                          listen: false);
                                      final medicineProvider =
                                      Provider.of<MedicineNotifier>(context,
                                          listen: false);

                                      if (medicineName.isEmpty ||
                                          dosage.isEmpty) {
                                        newEntry.submitError(
                                            EntryErrors.emptyFields);
                                        AppSnackbar.msg(
                                            context, "${context.l10n.fillGaps}!");
                                        return;
                                      }

                                      if (medicineProvider.medicines
                                          .any((m) =>
                                      m.medicineName == medicineName)) {
                                        newEntry.submitError(
                                            EntryErrors.nameDuplicate);
                                        AppSnackbar.msg(context,
                                            "${context.l10n.alreadyExists}!");
                                        return;
                                      }

                                      if (newEntry.selectedInterval == 0) {
                                        newEntry
                                            .submitError(EntryErrors.interval);
                                        AppSnackbar.msg(context,
                                            "${context.l10n.selectInterval}!");
                                        return;
                                      }

                                      if (newEntry.selectedTimeOfDay == null ||
                                          newEntry.selectedTimeOfDay == "None") {
                                        AppSnackbar.msg(context,
                                            "${context.l10n.selectTime}!");
                                        return;
                                      }

                                      String medicineType = newEntry
                                          .selectedMedicineType
                                          .toString()
                                          .split('.')
                                          .last;
                                      int interval = newEntry.selectedInterval;
                                      String startTime =
                                      newEntry.selectedTimeOfDay!;

                                      List<int> intIDs =
                                      makeIDs(24 / interval);
                                      List<String> notificationIDs =
                                      intIDs.map((e) => e.toString()).toList();

                                      final medicine = Medicine(
                                        notificationIDs: notificationIDs,
                                        medicineName: medicineName,
                                        dosage: dosage,
                                        medicineType: medicineType,
                                        interval: interval,
                                        startTime: startTime,
                                      );
                                      medicineProvider.addMedicine(medicine);

                                      nameController.clear();
                                      dosageController.clear();
                                      newEntry.reset();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const SuccessScreen()),
                                      );
                                    },
                                    child: Center(
                                      child: Text(
                                        context.l10n.confirm,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(
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
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGlassCard(BuildContext context, {required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(3.h),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: EdgeInsets.all(3.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.3),
                Colors.white.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(3.h),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  TextStyle _textStyle(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
      fontSize: 16.sp,
      color: Colors.white,
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      counterStyle: TextStyle(color: Colors.white70, fontSize: 16.sp),
    );
  }

  List<int> makeIDs(double n) {
    final rand = Random();
    return List.generate(n.toInt(), (_) => rand.nextInt(10000000));
  }

}


