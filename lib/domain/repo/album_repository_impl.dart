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
  Future<List<Album>> getAlbums() async {
    if (albumBox.isNotEmpty) {
      return albumBox.values
          .map((album) => Album(id: album.id, title: album.title))
          .toList();
    }

    final response =
        await _dio.get('https://jsonplaceholder.typicode.com/albums');
    final albums = (response.data as List)
        .map((json) => Album(id: json['id'], title: json['title']))
        .toList();

    for (var album in albums) {
      albumBox.add(AlbumHiveModel(id: album.id, title: album.title));
    }

    return albums;
  }

  @override
  Future<List<Photo>> getPhotos(int albumId) async {
    if (photoBox.values.any((photo) => photo.albumId == albumId)) {
      return photoBox.values
          .where((photo) => photo.albumId == albumId)
          .map((photo) => Photo(id: photo.id, url: photo.url))
          .toList();
    }

    final response = await _dio.get(
      'https://jsonplaceholder.typicode.com/photos',
      queryParameters: {'albumId': albumId},
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
