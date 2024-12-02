import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/repo/album_repository.dart';
import 'album_state.dart';

class AlbumCubit extends Cubit<AlbumState> {
  final AlbumRepository repository;

  AlbumCubit({required this.repository})
      : super(AlbumState(albums: [], photosMap: {}, isLoading: true));

  Future<void> fetchAlbums() async {
    emit(state.copyWith(isLoading: true));

    final albums = await repository.getAlbums();
    emit(state.copyWith(albums: albums, isLoading: false));

    for (var album in albums) {
      final photos = await repository.getPhotos(album.id);
      state.photosMap[album.id] = photos;
      emit(state.copyWith(photosMap: state.photosMap));
    }
  }
}
