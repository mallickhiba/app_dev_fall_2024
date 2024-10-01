import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Post {
  final int id;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }
}

class PostListState extends StatefulWidget {
  const PostListState({super.key});

  @override
  State<PostListState> createState() => _PostListState();
}

class _PostListState extends State<PostListState> {
  List<Post> posts = [];

  Future<List<Post>> fetchAllPosts() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Post>>(
          future: fetchAllPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Failed to load posts');
            } else if (snapshot.hasData) {
              final posts = snapshot.data!;
              return ListView.separated(
                itemCount: posts.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Image.network('https://via.placeholder.com/150'),
                    ),
                    title: Text(post.title),
                    subtitle: Text(post.body),
                  );
                },
              );
            } else {
              return const Text('No posts available');
            }
          },
        ),
      ),
    );
  }
}
