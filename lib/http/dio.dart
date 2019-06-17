import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/tost.dart';

var dio = new Dio(new BaseOptions(
  baseUrl: "http://192.168.0.8:8081/",
  connectTimeout: 5000,
  receiveTimeout: 100000,
  contentType: ContentType.json,
  // Transform the response data to a String encoded with UTF8.
  // The default value is [ResponseType.JSON].
  responseType: ResponseType.json,
))
  ..interceptors.add(
      InterceptorsWrapper(
          onRequest: (RequestOptions options) async{
            // 在请求被发送之前做一些事情
            dio.interceptors.requestLock.lock();
            options.headers["token"] = await DioUtils.getPre('token');
            if(options.method == 'POST'){
              options.contentType = ContentType.parse("application/x-www-form-urlencoded");
            }
            dio.interceptors.requestLock.unlock();
            return options; //continue
            // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
            // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
            //
            // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
            // 这样请求将被中止并触发异常，上层catchError会被调用。
          },
          onResponse: (Response response) {
            print(response);
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
      LogInterceptor(request: false, requestHeader: false, responseHeader: false, responseBody: false),
  )
;

class Proxy {
//  设置代理
  static setProxy(String target) {
//    设置代理地址
    DioUtils.uri = 'http://$target/';
    dio.httpClientAdapter = new DefaultHttpClientAdapter();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.findProxy = (uri) {
        //proxy all request to localhost:8888
        return "PROXY $target";
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
  }
}

class DioUtils{

//  代理地址
  static String uri = 'http://192.168.0.230:8480/';

//  存储数据
  static Future<Null> setPre(String type, String key, value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    switch(type) {
      case 'String':
        pref.setString(key, value);
        break;
      case 'Int':
        pref.setInt(key, value);
        break;
      case 'Double':
        pref.setDouble(key, value);
        break;
      case 'Bool':
        pref.setBool(key, value);
        break;
    }
  }

//  读取数据
  static Future<dynamic> getPre(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final _value = pref.get(key);
    return _value;
  }

//  删除数据
  static Future<Null> removePre(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(key);
  }

//  清空数据
  static Future<Null> clearPre() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

//  get请求
  static Future get(String url, {Map<String, dynamic> params}) async {
    BuildContext context;
    try {
      var response = await dio.get(url, queryParameters: params);
      return response.data;
    } on DioError catch(e) {
      Toast.toast(context, '数据出错啦！');
      print(e);
    }
  }

//  post请求
  static Future post(String url, Map<String, dynamic> params) async {
    try {
      var response = await dio.post(url, data: params);
      return response.data;
    } on DioError catch(e) {
      print(e);
    }
  }

}