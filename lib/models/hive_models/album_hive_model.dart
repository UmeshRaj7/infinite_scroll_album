import 'package:hive/hive.dart';

part 'album_hive_model.g.dart';

@HiveType(typeId: 0)
class AlbumHiveModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  AlbumHiveModel({required this.id, required this.title});
}
