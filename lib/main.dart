import 'package:flutter/material.dart';
import 'package:lookahead/screens/users_search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "users": (context) => UsersSearch(),
      },
      initialRoute: "users",
    );
  }
}
