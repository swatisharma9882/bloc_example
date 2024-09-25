import 'dart:convert';

import 'package:bloc_example/models/post_model.dart';
import 'package:bloc_example/utilis/api_constant.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  Future<List<Posts>> fetchPost() async {
    final response = await http.get(Uri.parse(ApiConstant.baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Posts> posts = jsonData.map((data) => Posts.fromJson(data)).toList();
      return posts;
    } else {
      throw Exception("Failed to load posts");
    }
  }

  Future<void> addPost(Posts post) async {
    final response = await http.post(
      Uri.parse(ApiConstant.baseUrl),
      body: json.encode(post.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    print("url ${ApiConstant.baseUrl}, ${response.statusCode},${response.body}");

    if (response.statusCode == 200) {
      print("New post added");
    } else {
      throw Exception("Failed to add post");
    }
  }
}
