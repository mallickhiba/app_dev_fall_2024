import 'package:firebase_core/firebase_core.dart';
// import 'package:iba_course_2/authentication/auth_gate.dart';
import 'package:iba_course_2/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:iba_course_2/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyaApp());
}

class MyaApp extends StatelessWidget {
  const MyaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/homepage',
      routes: {
        '/homepage': (context) => const MyHomePage(),
      },
    );
  }
}
