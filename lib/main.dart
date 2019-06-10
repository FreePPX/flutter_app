import 'package:flutter/material.dart';
import './http/dio.dart';
import 'src/MainPage.dart';
import 'src/Login.dart';
import 'src/Home/SearchNavigatorWidget.dart';


void main() async{
//  var  token = await DioUtils.getPre('token');
//  await DioUtils.clearPre();
//  print(token);
//  DioUtils.setPre('string', 'token', 'd0e5b4ca61e6badecbdffa0763fe48ba');
  Proxy.setProxy('192.168.0.230:8480');
//  Proxy.setProxy('192.168.0.125:8480');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: MaterialColor(0xFFdf232f,
          const <int, Color>{
            50: const Color(0xFFdf232f),
            100: const Color(0xFFdf232f),
            200: const Color(0xFFdf232f),
            300: const Color(0xFFdf232f),
            400: const Color(0xFFdf232f),
            500: const Color(0xFFdf232f),
            600: const Color(0xFFdf232f),
            700: const Color(0xFFdf232f),
            800: const Color(0xFFdf232f),
            900: const Color(0xFFdf232f),
          },),
      ),
      debugShowCheckedModeBanner: true,
      title: '租街app',
      initialRoute: '/login',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => MainPage(),
        '/login': (BuildContext context) => LoginWidget(),
        '/search': (BuildContext context) => SearchNavigatorWidget(),
//        '/home': (BuildContext context) => HomePage(),
//        '/video': (BuildContext context) => VideoPage(),
//        '/my': (BuildContext context) => MyPage(),
      },
    );
  }
}
