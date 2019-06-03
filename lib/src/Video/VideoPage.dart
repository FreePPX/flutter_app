import 'package:flutter/material.dart';
import 'ListLayout.dart';

class VideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: new ListLayout(),
      ),
    );
  }
}
