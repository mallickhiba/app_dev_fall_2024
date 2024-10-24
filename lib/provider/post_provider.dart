import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

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
}

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];
  List<Post> get posts => _posts;
  int get postLength => _posts.length;

  void fetchPost() async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts')); // Correct API URL
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      _posts = jsonResponse.map<Post>((post) => Post.fromJson(post)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: const AppBarTheme(),
        useMaterial3: false,
      ),
      home: const MyHomePage(), // MyHomePage now inside MultiProvider
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post List Example'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: context.watch<PostProvider>().postLength,
          itemBuilder: (cxt, i) {
            var _item = context.watch<PostProvider>().posts[i];
            return ListTile(
              title: Text(_item.title),
              subtitle: Text(_item.body), // Adjusted to use 'body'
              leading: const CircleAvatar(
                child: Icon(Icons.person), // Placeholder icon
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('increment_floatingActionButton'),
        onPressed: () => context.read<PostProvider>().fetchPost(),
        tooltip: 'Fetch Posts',
        child: const Icon(Icons.add),
      ),
    );
  }
}
