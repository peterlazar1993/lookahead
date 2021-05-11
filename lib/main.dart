import 'package:flutter/material.dart';

class User {
  final String name;
  final String avatarUrl;

  User({required this.name, required this.avatarUrl});
}

var userList = [
  User(name: "Peter", avatarUrl: "someUrl"),
  User(name: "Mahith", avatarUrl: "anotherUrl"),
];

Widget userRenderer(User user) {
  return Row(
    children: [Text(user.name), Text(user.avatarUrl)],
  );
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchComponent<User>(dataSource: userList, renderer: userRenderer),
    );
  }
}

class SearchComponent<T> extends StatefulWidget {
  final List<T> dataSource;
  final Widget Function(T) renderer;

  SearchComponent({
    Key? key,
    required List<T> dataSource,
    required Widget Function(T) renderer,
  })   : this.dataSource = dataSource,
        this.renderer = renderer,
        super(key: key);

  @override
  _SearchComponentState createState() => _SearchComponentState<T>();
}

class _SearchComponentState<T> extends State<SearchComponent<T>> {
  String searchString = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search ...',
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, index) {
                    return widget.renderer(widget.dataSource[index]);
                  },
                  itemCount: widget.dataSource.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
