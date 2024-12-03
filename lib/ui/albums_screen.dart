import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/album_cubit.dart';
import '../bloc/album_state.dart';
import 'ui.dart';

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({super.key});

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  late AlbumCubit _cubit;
  final ScrollController _albumScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cubit = context.read<AlbumCubit>();
    _cubit.fetchAlbums();

    _albumScrollController.addListener(() {
      if (_albumScrollController.position.pixels >=
          _albumScrollController.position.maxScrollExtent - 200) {
        _cubit.fetchAlbums(isInitialLoad: false);
      }
    });
  }

  @override
  void dispose() {
    _albumScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinite Albums'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: BlocBuilder<AlbumCubit, AlbumState>(
          builder: (context, state) {
            if (state.isLoading && state.albums.isEmpty) {
              return Center(child: const CircularProgressIndicator());
            }

            return ListView.builder(
              controller: _albumScrollController,
              itemCount:
                  state.albums.length + (state.isFetchingMoreAlbums ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= state.albums.length) {
                  return const Center(child: CircularProgressIndicator());
                }

                final album = state.albums[index];
                final photos = state.photosMap[album.id] ?? [];

                return AlbumTile(
                  album: album,
                  photos: photos,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
