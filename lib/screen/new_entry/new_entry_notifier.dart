import 'package:flutter/cupertino.dart';

import '../../core/models/errors.dart';
import '../../core/models/medicine_type.dart';


class NewEntryNotifier extends ChangeNotifier{
  MedicineType _selectedMedicineType = MedicineType.none;
  MedicineType get selectedMedicineType => _selectedMedicineType;

  int _selectedInterval = 0;
  int get selectedInterval => _selectedInterval;

  String? _selectedTimeOfDay;
  String? get selectedTimeOfDay => _selectedTimeOfDay;

  EntryErrors? _errorState;
  EntryErrors? get errorState => _errorState;

  void submitError(EntryErrors error){
    _errorState = error;
    notifyListeners();
  }

  void updateInterval(int interval){
    _selectedInterval = interval;
    notifyListeners();
  }

  void updateTime(String time){
    _selectedTimeOfDay = time;
    notifyListeners();
  }

  void updateSelectedMedicine(MedicineType type){
    if(_selectedMedicineType == type){
      _selectedMedicineType = MedicineType.none;
    }
    else{
      _selectedMedicineType = type;
    }
    notifyListeners();
  }

  void reset(){
    _selectedMedicineType = MedicineType.none;
    _selectedInterval = 0;
    _selectedTimeOfDay = "None";
    notifyListeners();
  }
}