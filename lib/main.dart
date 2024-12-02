import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:infinite_photo_album/ui/albums_screen.dart';

import 'bloc/album_cubit.dart';
import 'domain/repo/album_repository.dart';
import 'domain/repo/album_repository_impl.dart';
import 'models/models.dart';

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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
          create: (_) => AlbumCubit(repository: repository),
          child: const AlbumsScreen()),
    );
  }
}
