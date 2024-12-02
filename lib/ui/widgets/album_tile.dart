import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinite_photo_album/bloc/album_state.dart';

import '../../bloc/album_cubit.dart';
import '../../models/models.dart';

class AlbumTile extends StatelessWidget {
  final Album album;
  final List<Photo> photos;
  final AlbumCubit cubit;
  final AlbumState albumState;
  const AlbumTile(
      {super.key,
      required this.album,
      required this.photos,
      required this.cubit,
      required this.albumState});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(album.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: photos.length +
                (albumState.isFetchingMorePhotos[album.id] == true ? 1 : 0),
            itemBuilder: (context, photoIndex) {
              if (photoIndex >= photos.length) {
                cubit.fetchPhotos(album.id, page: (photos.length ~/ 20) + 1);
                return const Center(child: CircularProgressIndicator());
              }

              final photo = photos[photoIndex];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  imageUrl: photo.url,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
