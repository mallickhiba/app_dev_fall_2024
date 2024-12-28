import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iba_course_2/bloc/juice_bloc/juice_bloc.dart';
// import 'package:iba_course_2/authentication/auth_gate.dart';
import 'package:iba_course_2/firebase_options.dart';
import 'package:flutter/material.dart';
// import 'package:iba_course_2/home_page.dart';
import 'package:iba_course_2/juice_page.dart';
import 'package:iba_course_2/recommended_page.dart';
import 'package:iba_course_2/juice_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    BlocProvider(
      create: (context) => JuiceBloc(JuiceService())..add(FetchJuice()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/homepage',
      routes: {
        '/homepage': (context) => const JuicePage(),
        '/recpage': (context) => const RecommendedPage(),
      },
    );
  }
}
