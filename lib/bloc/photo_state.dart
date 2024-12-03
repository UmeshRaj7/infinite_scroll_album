import '../models/models.dart';

abstract class PhotoState {}

class PhotoInitial extends PhotoState {}

class PhotoLoaded extends PhotoState {
  final Map<int, List<Photo>> photos;

  PhotoLoaded({required this.photos});
}

class PhotoError extends PhotoState {
  final String message;

  PhotoError(this.message);
}
