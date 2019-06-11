import 'package:flutter/material.dart';
import '../http/dio.dart';

class MyPageWidget extends StatefulWidget {
  MyPageWidget({Key key}): super(key: key);
  @override
  _MyPageWidgetState createState() => _MyPageWidgetState();
}

class _MyPageWidgetState extends State<MyPageWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final token = await DioUtils.getPre('token');
    print(token);
    if(token == null) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', ModalRoute.withName('/'));
//      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: new Center(child:new Text("MyPage")),
      ),
    );
  }
}

