import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/models/medicine.dart';
import 'core/service/notification_service.dart';

class MedicineNotifier extends ChangeNotifier {
  List<Medicine> _medicines = [];
  List<Medicine> get medicines => _medicines;

  final NotificationService _notificationService = NotificationService();
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  MedicineNotifier(){
    _loadMedicines();
  }

  Future<void> _loadMedicines() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? storedList = prefs.getStringList('medicine');
      if (storedList != null) {
        _medicines = storedList
            .map((medicineJson) =>
            Medicine.fromJson(json.decode(medicineJson)))
            .toList();
        print('Loaded ${_medicines.length} medicines from SharedPreferences');
      }
      else{
        print('No medicines found in SharedPreferences');
      }
    }catch(e){
      print('Error loading medicines: $e');
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addMedicine(Medicine medicine) async {
    try {
      print('Adding medicine: ${medicine.medicineName}');
      _medicines.add(medicine);
      await _saveToPrefs();
      print('Medicine added successfully. Total count: ${_medicines.length}');
    } catch (e) {
      print('Error adding medicine: $e');
    }
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> jsonList = _medicines.map((medicine) => json.encode(medicine.toJson())).toList();
      await prefs.setStringList('medicine', jsonList);
      print('Saved ${jsonList.length} medicines to SharedPreferences');
    }catch(e){
      print('Error saving to SharedPreferences: $e');
    }
  }

  Future<void> deleteMedicine(int index) async {
    if(index>=0 && index < _medicines.length){
      _medicines.removeAt(index);
      await _saveToPrefs();
      notifyListeners();
    }
  }
}