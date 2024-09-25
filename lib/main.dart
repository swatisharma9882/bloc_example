import 'package:bloc_example/screens/post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/post/post_bloc.dart';
import 'bloc/post/post_event.dart';
import 'repositories/post_repository.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BLoC Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (context) => PostBloc(PostRepository())..add(FetchPosts()),
        child: const PostPage(),
      ),
    );
  }
}
