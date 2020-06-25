import 'package:dio/dio.dart';

class HttpRequest {
  static final BaseOptions options = BaseOptions(baseUrl: "");

  static final Dio dio = Dio(options);

  static Future<T> request<T>(String url,
      {String method, Map<String, dynamic> params, Interceptor inter}) async {
    // 1.请求的单独配置
    Options options = Options(method: method);
    options.headers = httpHeaders;
//    // 2.添加第一个拦截器
//    Interceptor dInter =
//        InterceptorsWrapper(onRequest: (RequestOptions options) {
//      // 1.在进行任何网络请求的时候, 可以添加一个loading显示
//
//      // 2.很多页面的访问必须要求携带Token,那么就可以在这里判断是有Token
//
//      // 3.对参数进行一些处理,比如序列化处理等
//      print("拦截了请求");
//      return options;
//    }, onResponse: (Response response) {
//      print("拦截了响应");
//      return response;
//    }, onError: (DioError error) {
//      print("拦截了错误");
//      return error;
//    });
//
//    List<Interceptor> inters = [dInter];
//    if (inter != null) {
//      inters.add(inter);
//    }
//
//    dio.interceptors.addAll(inters);
    // 3.发送网络请求
    try {
      Response response =
          await dio.request(url, data: params, options: options);
      return response.data;
    } on DioError catch (e) {
      return Future.error(e);
    }
  }
}

const httpHeaders = {
  'Content-Type': 'application/json',
  'X-LC-Id': 'a4Cj1Hm5aMrdhob6xGw71B5A-gzGzoHsz',
  'X-LC-Key': 'XQaL1tUQC0DCQxBA9fpoR21C',
//  'X-LC-Key': 'XQaL1tUQC0DCQxBA9fpoR21C',
};
