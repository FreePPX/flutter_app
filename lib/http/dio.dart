import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

String token = '';

Future<Null> _getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  token = pref.get('token');
}

var dio = new Dio(new BaseOptions(
  baseUrl: "http://192.168.0.230:8480/",
  connectTimeout: 5000,
  receiveTimeout: 100000,
  contentType: ContentType.json,
  // Transform the response data to a String encoded with UTF8.
  // The default value is [ResponseType.JSON].
  responseType: ResponseType.plain,
))
  ..interceptors.add(
      InterceptorsWrapper(
          onRequest: (RequestOptions options) {
            // 在请求被发送之前做一些事情
            return options; //continue
            // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
            // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
            //
            // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
            // 这样请求将被中止并触发异常，上层catchError会被调用。
          },
          onResponse: (Response response) {
            // 在返回响应数据之前做一些预处理
            return response; // continue
          },
          onError: (DioError e) {
            // 当请求失败时做一些预处理
            return e; //continue
          }
      ))
  ..interceptors.add(
    //    控制台打印
      LogInterceptor(request: false,responseHeader: false, requestHeader: false, responseBody: true)
  )
;


class DioUtils{
  static Future get(String url, {Map<String, dynamic> params}) async {
    await _getToken();
    if(token != '') {
      dio.options.headers = {'token': token};
    }
    var response = await dio.get(url, queryParameters: params);
    return response.data;
  }

  static Future post(String url, Map<String, dynamic> params) async {
    await _getToken();
    if(token != '') {
      dio.options.headers = {'token': token};
    }
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    var response = await dio.post(url, data: params);
    return response.data;
  }
}


