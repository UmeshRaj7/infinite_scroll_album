import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:infinite_photo_album/ui/albums_screen.dart';

import 'bloc/album_cubit.dart';
import 'models/hive_models/hive.dart';
import 'repos/repos.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AlbumHiveModelAdapter());
  Hive.registerAdapter(PhotoHiveModelAdapter());

  final albumBox = await Hive.openBox<AlbumHiveModel>('albums');
  final photoBox = await Hive.openBox<PhotoHiveModel>('photos');

  runApp(MyApp(
    repository: AlbumRepositoryImpl(albumBox: albumBox, photoBox: photoBox),
  ));
}

class MyApp extends StatelessWidget {
  final AlbumRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => AlbumCubit(repository: repository),
        child: const AlbumsScreen(),
      ),
    );
  }
}
