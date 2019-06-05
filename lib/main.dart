import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import './http/dio.dart';
import 'src/MainPage.dart';
import 'src/Login.dart';
import 'src/Home/SearchNavigatorWidget.dart';

void _add() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('token', 'd0e5b4ca61e6badecbdffa0763fe48ba');
}

void main() {
  _add();
  Proxy.setProxy('192.168.0.230:8480');
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
