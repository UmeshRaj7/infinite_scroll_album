import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/repo/album_repository.dart';
import 'album_state.dart';

class AlbumCubit extends Cubit<AlbumState> {
  final AlbumRepository repository;
  final int itemsPerPage;

  AlbumCubit({required this.repository, this.itemsPerPage = 20})
      : super(AlbumState(
          albums: [],
          photosMap: {},
          isLoading: true,
          isFetchingMoreAlbums: false,
          isFetchingMorePhotos: {},
          currentAlbumPage: 1,
        ));

  Future<void> fetchAlbums({bool isInitialLoad = true}) async {
    if (!isInitialLoad && state.isFetchingMoreAlbums) return;

    emit(state.copyWith(
      isLoading: isInitialLoad,
      isFetchingMoreAlbums: !isInitialLoad,
    ));

    final albums = await repository.getAlbums(
        page: state.currentAlbumPage, limit: itemsPerPage);
    emit(state.copyWith(
      albums: List.of(state.albums)..addAll(albums),
      isLoading: false,
      isFetchingMoreAlbums: false,
      currentAlbumPage: state.currentAlbumPage + 1,
    ));
  }

  Future<void> fetchPhotos(int albumId, {int page = 1}) async {
    if (state.isFetchingMorePhotos[albumId] == true) return;

    emit(state.copyWith(
      isFetchingMorePhotos: {...state.isFetchingMorePhotos, albumId: true},
    ));

    final photos =
        await repository.getPhotos(albumId, page: page, limit: itemsPerPage);
    emit(state.copyWith(
      photosMap: {
        ...state.photosMap,
        albumId: List.of(state.photosMap[albumId] ?? [])..addAll(photos),
      },
      isFetchingMorePhotos: {...state.isFetchingMorePhotos, albumId: false},
    ));
  }
}
