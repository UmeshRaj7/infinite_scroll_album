import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../models/models.dart';
import 'album_repository.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final Dio _dio = Dio();
  final Box<AlbumHiveModel> albumBox;
  final Box<PhotoHiveModel> photoBox;

  AlbumRepositoryImpl({required this.albumBox, required this.photoBox});

  @override
  Future<List<Album>> getAlbums({required int page, required int limit}) async {
    final start = (page - 1) * limit;
    final end = start + limit;

    // Check if cached data exists for this range
    if (albumBox.length >= end) {
      return albumBox.values
          .skip(start)
          .take(limit)
          .map((album) => Album(id: album.id, title: album.title))
          .toList();
    }

    // Fetch from API
    final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/albums?_start=$start&_limit=$limit');
    final albums = (response.data as List)
        .map((json) => Album(id: json['id'], title: json['title']))
        .toList();

    for (var album in albums) {
      albumBox.add(AlbumHiveModel(id: album.id, title: album.title));
    }

    return albums;
  }

  @override
  Future<List<Photo>> getPhotos(int albumId,
      {required int page, required int limit}) async {
    final start = (page - 1) * limit;
    final end = start + limit;

    // Check if cached data exists for this range
    final cachedPhotos =
        photoBox.values.where((photo) => photo.albumId == albumId).toList();
    if (cachedPhotos.length >= end) {
      return cachedPhotos
          .skip(start)
          .take(limit)
          .map((photo) => Photo(id: photo.id, url: photo.url))
          .toList();
    }

    // Fetch from API
    final response = await _dio.get(
      'https://jsonplaceholder.typicode.com/photos',
      queryParameters: {'albumId': albumId, '_start': start, '_limit': limit},
    );

    final photos = (response.data as List)
        .map((json) => Photo(id: json['id'], url: json['url']))
        .toList();

    for (var photo in photos) {
      photoBox
          .add(PhotoHiveModel(id: photo.id, albumId: albumId, url: photo.url));
    }

    return photos;
  }
}
