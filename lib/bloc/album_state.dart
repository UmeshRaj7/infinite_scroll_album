import '../models/models.dart';

class AlbumState {
  final List<Album> albums;
  final Map<int, List<Photo>> photosMap;
  final bool isLoading;

  AlbumState(
      {required this.albums, required this.photosMap, required this.isLoading});

  AlbumState copyWith({
    List<Album>? albums,
    Map<int, List<Photo>>? photosMap,
    bool? isLoading,
  }) {
    return AlbumState(
      albums: albums ?? this.albums,
      photosMap: photosMap ?? this.photosMap,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
