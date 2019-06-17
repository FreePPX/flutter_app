import 'package:flutter/material.dart';
import '../src/main_page.dart';
import '../src/login.dart';
import '../src/Home/search_navigator_widget.dart';
import '../components/slide_transition.dart';

class RouterUtils {

//  路由path
  static Map<String, Widget> routePath([params]) {
    Map<String, Widget> pathMap = {
      '/': MainPage(),
      '/login': LoginWidget(params: params ?? null),
      '/search': SearchNavigatorWidget(),
    };
    return pathMap;
  }

//  构造路由
  static Map<String, WidgetBuilder> creatRoutes(){
    Map<String, WidgetBuilder> route = RouterUtils.routePath().map((String key, Widget value){
      return new MapEntry(key, (context) => value);
    });
    return route;
  }

//  路由跳转
  static routeHandles(BuildContext context, String path, [dynamic params]) {
    Navigator.push(context, PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return (routePath(params)[path]);
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