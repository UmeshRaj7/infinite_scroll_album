import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';

class AlbumTile extends StatelessWidget {
  final Album album;
  final List<Photo> photos;
  const AlbumTile({super.key, required this.album, required this.photos});

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
            itemCount: photos.length * 1000, // Infinite loop
            itemBuilder: (context, photoIndex) {
              final photo = photos[photoIndex % photos.length];
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
