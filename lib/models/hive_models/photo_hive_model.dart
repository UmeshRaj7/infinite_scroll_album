import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class PhotoHiveModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int albumId;

  @HiveField(2)
  String url;

  PhotoHiveModel({required this.id, required this.albumId, required this.url});
}
