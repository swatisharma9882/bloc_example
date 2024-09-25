import 'package:bloc_example/bloc/post/post_event.dart';
import 'package:bloc_example/bloc/post/post_state.dart';
import 'package:bloc_example/repositories/post_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(PostInitial()) {
    on<FetchPosts>(_onFetchPosts);
    on<AddPost>(_onAddPost);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final posts = await postRepository.fetchPost();
      emit(PostLoaded(posts));
    } catch (e) {
      emit(PostError('Failed to load posts: $e'));
    }
  }

  Future<void> _onAddPost(AddPost event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      await postRepository.addPost(event.post);
      add(FetchPosts()); // Re-fetch posts after adding
    } catch (e) {
      emit(PostError('Failed to add post: $e'));
    }
  }
}
