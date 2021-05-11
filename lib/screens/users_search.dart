import 'package:flutter/material.dart';
import 'package:lookahead/lookahead.dart';

class UsersSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 16, left: 8, right: 8),
          child: Lookahead<User>(
              dataSource: userDataSource,
              renderer: userRenderer,
              extractSearchableString: (User user) => user.name),
        ),
      ),
    );
  }
}

class User {
  final String name;
  final String avatarUrl;

  User({required this.name, required this.avatarUrl});
}

List<User> userDataSource = [
  User(name: "Peter Lazar", avatarUrl: 'https://i.pravatar.cc/300'),
  User(name: "Mahith Menon", avatarUrl: 'https://i.pravatar.cc/300'),
  User(name: "Dennis Chapman", avatarUrl: 'https://i.pravatar.cc/300')
];

Widget userRenderer(User user) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(foregroundImage: NetworkImage(user.avatarUrl)),
        SizedBox(
          width: 10,
        ),
        Text(user.name)
      ],
    ),
  );
}
