import 'package:flutter/material.dart';
import '../src/main_page.dart';
import '../src/login.dart';
import '../src/Home/search_navigator_widget.dart';
import '../components/slide_transition.dart';

class RouterUtils {

//  static Map<String, WidgetBuilder> routes = {
//    '/': (context) => MainPage(),
//    '/login': (context) => LoginWidget(),
//    '/search': (context) => SearchNavigatorWidget(),
//  };

  static Map<String, Widget> routeF = {
    '/': MainPage(),
    '/login': LoginWidget(),
    '/search': SearchNavigatorWidget(),
  };

  static routeHandles(BuildContext context, String routePath) {
    Navigator.push(context, PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return routeF[routePath];
//          return pageWidget;
        },
        transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
            ) {
          return SlideTransitionModel
              .createTransition(animation, child);
        }
    ));
  }

}