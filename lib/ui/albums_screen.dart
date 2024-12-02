import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

  @override
  void initState() {
    super.initState();
    _cubit = context.read<AlbumCubit>();
    _cubit.fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Infinite Albums'),
      ),
      body: BlocBuilder<AlbumCubit, AlbumState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: state.albums.length * 1000, // Infinite loop
            itemBuilder: (context, index) {
              final album = state.albums[index % state.albums.length];
              final photos = state.photosMap[album.id] ?? [];

              return AlbumTile(album: album,photos: photos,);
            },
          );
        },
      ),
    );
  }
}
