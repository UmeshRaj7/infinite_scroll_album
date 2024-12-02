import 'package:hive/hive.dart';

part '../hive_models.g.dart';

@HiveType(typeId: 0)
class AlbumHiveModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  AlbumHiveModel({required this.id, required this.title});
}
