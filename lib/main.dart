import 'package:firebase_core/firebase_core.dart';
import 'package:iba_course_2/authentication/auth_gate.dart';
import 'package:iba_course_2/firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/authGate',
      routes: {
        '/authGate': (context) =>
            const AuthGate(), //in lib>authentication>services
      },
    );
  }
}
