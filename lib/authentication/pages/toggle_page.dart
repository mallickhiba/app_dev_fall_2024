import 'package:flutter/material.dart';
import 'package:iba_course_2/authentication/pages/sign_in_page.dart';
import 'package:iba_course_2/authentication/pages/sign_up_page.dart';

class TogglePage extends StatefulWidget {
  const TogglePage({super.key});

  @override
  State<TogglePage> createState() => _TogglePageState();
}

class _TogglePageState extends State<TogglePage> {
  bool showLogin = true;

  void togglePage() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return MySignInPage(
        onTap: togglePage,
      );
    } else {
      return MySignUpPage(
        onTap: togglePage,
      );
    }
  }
}
