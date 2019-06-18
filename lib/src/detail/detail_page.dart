import 'package:flutter/material.dart';

class DetailWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.popUntil(context, ModalRoute.withName('/'));
        },
        child: Text('DetailWidget'),
      ),
    );
  }
}
