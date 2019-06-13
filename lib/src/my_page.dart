import 'package:flutter/material.dart';
import 'package:flutterapp/http/dio.dart';

class MyPageWidget extends StatefulWidget {
  MyPageWidget({Key key}): super(key: key);
  @override
  _MyPageWidgetState createState() => _MyPageWidgetState();
}

class _MyPageWidgetState extends State<MyPageWidget> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: new Center(
            child: Column(
              children: <Widget>[
                Text("MyPage"),
                RaisedButton(
                  onPressed: (){
                    DioUtils.removePre('token');
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text('退出登录'),
                ),
              ],
            )
        ),
      ),
    );
  }
}

