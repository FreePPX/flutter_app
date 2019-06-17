import 'package:flutter/material.dart';
import './http/dio.dart';
import './router/routes.dart';

var _token;

void main() async{
//  await DioUtils.clearPre();
//  DioUtils.setPre('String', 'token', 'd0e5b4ca61e6badecbdffa0763fe48ba');
  _token = await DioUtils.getPre('token');
  Proxy.setProxy('192.168.0.230:8480');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        primarySwatch: MaterialColor(0xFFdf232f,
          const <int, Color>{
            50: const Color(0xF2df232f),
            100: const Color(0xE5df232f),
            200: const Color(0xCCdf232f),
            300: const Color(0xB2df232f),
            400: const Color(0x99df232f),
            500: const Color(0x7Fdf232f),
            600: const Color(0x66df232f),
            700: const Color(0x4Cdf232f),
            800: const Color(0x33df232f),
            900: const Color(0x19df232f),
          },),
      ),
      debugShowCheckedModeBanner: true,
      title: '租街app',
      initialRoute: _token == null ? '/login': '/',
      routes: RouterUtils.creatRoutes(),
    );
  }
}
