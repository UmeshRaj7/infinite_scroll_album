import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../models/models.dart';

class AlbumTile extends StatelessWidget {
  final Album album;
  final List<Photo> photos;
  const AlbumTile({
    super.key,
    required this.album,
    required this.photos,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(album.title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 100, // Set a fixed height for the photo row
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              // Wrap the index using modulus operator to loop photos infinitely
              final photo = photos[index % photos.length];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CachedNetworkImage(
                  imageUrl: photo.url,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              );
            },
            // A very high value for itemCount to simulate infinite scrolling
            itemCount: 1000000,
          ),
        ),
      ],
    );
  }
}
