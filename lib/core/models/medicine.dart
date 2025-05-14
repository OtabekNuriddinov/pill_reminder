class Medicine {
  final List<String> notificationIDs;
  final String medicineName;
  final String dosage;
  final String medicineType;
  final int interval;
  final String startTime;

  Medicine({
    required this.notificationIDs,
    required this.medicineName,
    required this.dosage,
    required this.medicineType,
    required this.interval,
    required this.startTime,
  });

  String get getName => medicineName;
  String get getDosage => dosage;
  String get getType => medicineType;
  int get getInterval => interval;
  String get getStartTime => startTime;
  List<dynamic> get getIDs => notificationIDs;

  factory Medicine.fromJson(Map<String, dynamic>json){
    return Medicine(
      notificationIDs: json['notificationIDs'] != null ?List.from(json['notificationIDs']):[],
      medicineName: json['medicineName'],
      dosage: json['dosage'],
      medicineType: json['medicineType'],
      interval: json['interval'],
      startTime: json['startTime'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "notificationIDs": notificationIDs ?? [],
      "medicineName": medicineName,
      "dosage": dosage,
      "medicineType": medicineType,
      "interval": interval,
      "startTime": startTime,
    };
  }
}
