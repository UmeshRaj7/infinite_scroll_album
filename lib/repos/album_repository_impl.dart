import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../models/models.dart';
import '../models/hive_models/hive.dart';
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

    // Check cached data for albums
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

    // Retrieve all cached photos for the album
    final cachedPhotos =
        photoBox.values.where((photo) => photo.albumId == albumId).toList();

    // Sort cached photos by ID (or another consistent order)
    cachedPhotos.sort((a, b) => a.id.compareTo(b.id));

    // If the requested range is fully cached, return the data
    if (cachedPhotos.isNotEmpty && cachedPhotos.length >= end) {
      return cachedPhotos.skip(start).take(limit).map((photo) {
        return Photo(id: photo.id, url: photo.url);
      }).toList();
    }

    // Fetch missing data from the API
    final response = await _dio.get(
      'https://jsonplaceholder.typicode.com/photos',
      queryParameters: {'albumId': albumId, '_start': start, '_limit': limit},
    );

    final photos = (response.data as List)
        .map((json) => Photo(id: json['id'], url: json['thumbnailUrl']))
        .toList();

    // Cache the newly fetched photos
    for (var photo in photos) {
      // Ensure no duplicates in cache
      if (!photoBox.values.any((cached) => cached.id == photo.id)) {
        photoBox.add(PhotoHiveModel(
          id: photo.id,
          albumId: albumId,
          url: photo.url,
        ));
      }
    }

    return photos;
  }
}
