import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

var dio = new Dio(new BaseOptions(
  baseUrl: "http://192.168.0.8:8081/",
//  baseUrl: "http://localhost:60968/",
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
            await _getToken();
            options.headers["token"] = await _getToken();
            if(options.method == 'post')
              dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
            dio.interceptors.requestLock.unlock();
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
      LogInterceptor(request: false, requestHeader: false, responseHeader: false, responseBody: false),
  )
;

Future<String> _getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.get('token');
}

class DioUtils{

  static String api = 'http://192.168.0.230:8480/';

  static Future get(String url, {Map<String, dynamic> params}) async {
    var response = await dio.get(url, queryParameters: params);
    return response.data;
  }

  static Future post(String url, Map<String, dynamic> params) async {
    var response = await dio.post(url, data: params);
    return response.data;
  }

}

class Proxy {
  static setProxy(String target) {
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