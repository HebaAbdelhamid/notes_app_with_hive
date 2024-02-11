class DataManagement{
  static String currentDateTime(){
     final date=DateTime.now();
     return"${date.day}-${date.month}-${date.year}-${date.hour}-${date.minute}-${date.second}-${date.millisecond}-${date.microsecond}";

  }
  static final date=DateTime.now();
  @override
  String toString() {

    return"${date.day}-${date.month}-${date.year}-${date.hour}-${date.minute}-${date.second}-${date.millisecond}-${date.microsecond}";
  }
}