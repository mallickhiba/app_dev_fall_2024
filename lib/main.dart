import 'package:flutter/material.dart';
// import 'package:iba_course_2/lect2/custom_tab.dart';
// import 'package:iba_course_2/lect3/bottom_nav_bar.dart';
// import 'package:iba_course_2/lect3/job_list.dart';
import 'package:iba_course_2/lect3/launch_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: const AppBarTheme(),
        useMaterial3: false,
      ),
      home: const LaunchListState(),
    );
  }
}
