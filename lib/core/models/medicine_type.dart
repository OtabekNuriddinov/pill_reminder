enum MedicineType{
  bottle,
  pill,
  syringe,
  tablet,
  none
}

extension MedicineTypeExtension on MedicineType{
  static MedicineType fromString(String type){
    switch(type.toLowerCase().trim()){
      case 'bottle': return MedicineType.bottle;
      case 'pill': return MedicineType.pill;
      case 'syringe': return MedicineType.syringe;
      case 'tablet': return MedicineType.tablet;
      default: return MedicineType.none;
    }
  }
}