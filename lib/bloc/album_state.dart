import '../models/models.dart';

class AlbumState {
  final List<Album> albums;
  final Map<int, List<Photo>> photosMap;
  final bool isLoading;
  final bool isFetchingMoreAlbums;
  final Map<int, bool> isFetchingMorePhotos;
  final int currentAlbumPage;

  AlbumState({
    required this.albums,
    required this.photosMap,
    required this.isLoading,
    required this.isFetchingMoreAlbums,
    required this.isFetchingMorePhotos,
    required this.currentAlbumPage,
  });

  AlbumState copyWith({
    List<Album>? albums,
    Map<int, List<Photo>>? photosMap,
    bool? isLoading,
    bool? isFetchingMoreAlbums,
    Map<int, bool>? isFetchingMorePhotos,
    int? currentAlbumPage,
  }) {
    return AlbumState(
      albums: albums ?? this.albums,
      photosMap: photosMap ?? this.photosMap,
      isLoading: isLoading ?? this.isLoading,
      isFetchingMoreAlbums: isFetchingMoreAlbums ?? this.isFetchingMoreAlbums,
      isFetchingMorePhotos: isFetchingMorePhotos ?? this.isFetchingMorePhotos,
      currentAlbumPage: currentAlbumPage ?? this.currentAlbumPage,
    );
  }
}
