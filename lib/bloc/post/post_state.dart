import 'package:bloc_example/models/post_model.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Posts> post;

  PostLoaded(this.post);
}

class PostError extends PostState {
  final String message;

  PostError(this.message);
}
