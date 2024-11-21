import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_course_2/bloc/news_bloc_bloc.dart';
import 'package:iba_course_2/news_page.dart';
import 'package:iba_course_2/news_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: AppBarTheme(),
        useMaterial3: false,
      ),
      home: BlocProvider(
        create: (context) => NewsBloc(NewsService()),
        child: NewsPage(),
      ),
    );
  }
}
