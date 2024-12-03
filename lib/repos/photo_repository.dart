import '../../models/models.dart';

abstract class IPhotoRepository {
  Future<List<Photo>> getPhotos(int albumId,
      {required int page, required int limit});
}
