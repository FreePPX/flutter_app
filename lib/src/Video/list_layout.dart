import 'package:flutter/material.dart';

class ListLayout extends StatefulWidget {
  ListLayout({Key key}):super(key:key);
  @override
  _ListLayoutState createState() => new _ListLayoutState();
}

class _ListLayoutState extends State<ListLayout> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return Text('entry $index');
      },
    );
  }
}