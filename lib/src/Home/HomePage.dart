import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new ReadLayout()
    );
  }
}
class ReadLayout extends StatefulWidget {
  @override
  _ReadLayoutState createState() => _ReadLayoutState();
}

class _ReadLayoutState extends State<ReadLayout> {
  final List<int> listData = [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: listData.map((int item) {
          return Container(
            height: 50,
            color: Colors.amber[(item*50)],
            child: const Center(child: Text('Entry A')),
          );
        }).toList(),
      ),
    );
  }
}
