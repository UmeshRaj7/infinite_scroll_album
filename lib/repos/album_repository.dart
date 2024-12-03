import '../../models/models.dart';

abstract class AlbumRepository {
  Future<List<Album>> getAlbums({required int page, required int limit});
  Future<List<Photo>> getPhotos(int albumId,
      {required int page, required int limit});
}
