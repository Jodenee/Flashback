import 'package:hive/hive.dart';

part 'flashback.g.dart';

@HiveType(typeId: 0)
class Flashback extends HiveObject {
  @HiveField(0)
  String text;

  @HiveField(1)
  double latitude;

  @HiveField(2)
  double longitude;

  Flashback({
    required this.text,
    required this.latitude,
    required this.longitude,
  });
}
