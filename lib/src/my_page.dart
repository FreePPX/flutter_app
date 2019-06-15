import 'package:flutter/material.dart';
import 'login.dart';
import '../http/dio.dart';
import '../router/routes.dart';

class MyPageWidget extends StatefulWidget {
  MyPageWidget({Key key}): super(key: key);
  @override
  _MyPageWidgetState createState() => _MyPageWidgetState();
}

class _MyPageWidgetState extends State<MyPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
          child: Column(
            children: <Widget>[
              Text("MyPage"),
              RaisedButton(
                onPressed: (){
//                  DioUtils.removePre('token');
                  RouterUtils.routeHandles(context, '/login');
//                  RouterUtils.routeHandles(context, LoginWidget(params: {'name': 'yang', 'age': 24, 'sex': 'man'}));
//                  Navigator.pushNamed(context, '/login', arguments: {'age': 12});
                },
                child: Text('退出登录'),
              ),
            ],
          )
      ),
    );
  }
}
