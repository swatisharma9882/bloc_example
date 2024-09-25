import 'package:bloc_example/bloc/post/post_bloc.dart';
import 'package:bloc_example/bloc/post/post_event.dart';
import 'package:bloc_example/bloc/post/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/post_model.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  void _addPost(BuildContext context) {
    if (titleController.text.isNotEmpty && bodyController.text.isNotEmpty) {
      final post = Posts(
        id: 0, // ID will be generated by the server
        title: titleController.text,
        body: bodyController.text,
        userId: 1,
      );

      context.read<PostBloc>().add(AddPost(post)); // Use context.read here
      titleController.clear();
      bodyController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            return ListView.builder(
              itemCount: state.post.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.post[index].title ?? ""),
                  subtitle: Text(state.post[index].body ?? ""),
                );
              },
            );
          } else if (state is PostError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text("No Posts found"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    TextField(
                      controller: bodyController,
                      decoration: const InputDecoration(labelText: 'Body'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      _addPost(context);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
