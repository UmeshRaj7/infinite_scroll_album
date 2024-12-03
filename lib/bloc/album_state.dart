import '../models/models.dart';

class AlbumState {
  final List<Album> albums;
  final Map<int, List<Photo>> photosMap;
  final bool isLoading;
  final bool isFetchingMoreAlbums;
  final Map<int, bool> isFetchingPhotosForAlbum;
  final int currentAlbumPage;

  AlbumState({
    required this.albums,
    required this.photosMap,
    required this.isLoading,
    required this.isFetchingMoreAlbums,
    required this.isFetchingPhotosForAlbum,
    required this.currentAlbumPage,
  });

  AlbumState copyWith({
    List<Album>? albums,
    Map<int, List<Photo>>? photosMap,
    bool? isLoading,
    bool? isFetchingMoreAlbums,
    Map<int, bool>? isFetchingPhotosForAlbum,
    int? currentAlbumPage,
  }) {
    return AlbumState(
      albums: albums ?? this.albums,
      photosMap: photosMap ?? this.photosMap,
      isLoading: isLoading ?? this.isLoading,
      isFetchingMoreAlbums: isFetchingMoreAlbums ?? this.isFetchingMoreAlbums,
      isFetchingPhotosForAlbum:
          isFetchingPhotosForAlbum ?? this.isFetchingPhotosForAlbum,
      currentAlbumPage: currentAlbumPage ?? this.currentAlbumPage,
    );
  }
}
