import 'package:bloc_example/models/post_model.dart';

abstract class PostEvent {}

class FetchPosts extends PostEvent {}

class AddPost extends PostEvent {
  final Posts post;

  AddPost(this.post);
}
