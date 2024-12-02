import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iba_course_2/authentication//widgets/sign_in_up_button.dart';
import 'package:iba_course_2/friends/friends_add.dart';
import 'package:iba_course_2/friends/friends_services.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Friends'), actions: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddFriend()));
              },
              icon: const Icon(Icons.add)),
        )
      ]),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('friends').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No friends added yet.'));
          }
          final friends = snapshot.data!.docs;
          return ListView.builder(
            itemCount: friends.length,
            itemBuilder: (context, index) {
              final friend = friends[index].data();
              return ListTile(
                title: Text(friend['name']),
                subtitle: Text(friend['email']),
                trailing: IconButton(
                    onPressed: () async {
                      deleteFriendFromFirestore(
                          friend['name'], friend['email'], context);
                    },
                    icon: const Icon(Icons.delete)),
              );
            },
          );
        },
      ),
    );
  }
}

void deleteFriendFromFirestore(
    String name, String email, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Are you sure you want to delete friend?',
            softWrap: true,
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MySignInUpButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: 'Cancel'),
              MySignInUpButton(
                  onTap: () async {
                    await Friends().deleteFriend(name, email);
                    Navigator.pop(context);
                  },
                  text: 'OK'),
            ],
          )
        ],
      );
    },
  );
}

// Center(
//         child: FloatingActionButton(
//           child: const Text('Logout'),
//           onPressed: (){
//             AuthService().signOut();
//           }
//           ),
//       ),