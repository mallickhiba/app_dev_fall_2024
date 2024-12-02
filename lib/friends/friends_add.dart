import 'package:iba_course_2/authentication//widgets/sign_in_up_button.dart';
import 'package:iba_course_2/friends/friends_services.dart';
import 'package:iba_course_2/authentication//widgets/input_field.dart';
import 'package:flutter/material.dart';

class AddFriend extends StatelessWidget {
  const AddFriend({super.key});

  Future<void> addFriendToFirebase(String name, String email) async {
    await Friends().addFriend(name, email);
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController name = TextEditingController();
    final TextEditingController email = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Friend'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyInputField(
                hintText: 'Enter friend name',
                obscureText: false,
                controller: name),
            MyInputField(
                hintText: 'Enter friend email',
                obscureText: false,
                controller: email),
            const SizedBox(
              height: 30,
            ),
            MySignInUpButton(
                onTap: () async {
                  await addFriendToFirebase(name.text, email.text);
                  name.clear();
                  email.clear();
                  Navigator.pop(context);
                },
                text: 'Add Friend')
          ],
        ),
      ),
    );
  }
}
