import 'package:hive/hive.dart';
part 'notes.g.dart';
@HiveType(typeId: 0)
class Note {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String ?text;
  @HiveField(2)
  String ?date;
  Note({this.title,this.text,this.date});
}