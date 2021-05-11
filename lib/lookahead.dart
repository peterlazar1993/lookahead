import 'package:flutter/material.dart';

class Lookahead<T> extends StatefulWidget {
  final List<T> dataSource;
  final Widget Function(T) renderer;
  final String Function(T) extractSearchableString;

  Lookahead({
    Key? key,
    required this.dataSource,
    required this.renderer,
    required this.extractSearchableString,
  }) : super(key: key);

  @override
  _LookaheadState createState() => _LookaheadState<T>();
}

class _LookaheadState<T> extends State<Lookahead<T>> {
  String searchValue = '';
  TextEditingController searchFieldController = TextEditingController();
  List<T> results = [];

  @override
  void initState() {
    results = [...widget.dataSource];
    searchFieldController.addListener(_search);
    super.initState();
  }

  void _search() {
    List<T> results = [];
    String searchString = searchFieldController.value.text.toLowerCase();

    if (searchString.isEmpty) {
      results = [...widget.dataSource];
    } else {
      results = findSearchResults(searchString);
    }
    setState(() {
      this.results = results;
    });
  }

  List<T> findSearchResults(String searchString) {
    return widget.dataSource
        .where((element) => widget
            .extractSearchableString(element)
            .toLowerCase()
            .contains(searchString))
        .toList();
  }

  @override
  void dispose() {
    searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: searchFieldController,
          onChanged: onChangeSearchString,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Search ...',
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 10),
            itemCount: results.length,
            itemBuilder: (BuildContext context, index) => widget.renderer(
              results[index],
            ),
          ),
        )
      ],
    );
  }

  void onChangeSearchString(value) => {
        setState(() {
          searchValue = value;
        })
      };
}
