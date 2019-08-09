import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app/global/config.dart';
import 'package:flutter_app/service/api_url.dart';

class HttpUtils {
  static HttpUtils instance;
  Dio _dio;
  BaseOptions options;

  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  static HttpUtils getInstance() {
    print('getInstance');
    if (instance == null) {
      instance = HttpUtils();
    }
    return instance;
  }

  HttpUtils({
    String baseUrl = ApiUrl.MOVIE_BASE_URL,
    Map<String, dynamic> header,
    String contentType = CONTENT_TYPE_FORM,
    Map<String, dynamic> queryParameters,
  }) {
    print('dio赋值');

    /// 或者通过传递一个 `options`来创建dio实例
    options = BaseOptions(
      /// 请求基地址,可以包含子路径，如: "https://www.google.com/api/".
      baseUrl: baseUrl,

      /// 连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,

      /// 接收数据的总时限.
      receiveTimeout: 3000,

      /// [如果返回数据是json(content-type)，dio默认会自动将数据转为json，无需再手动转](https://github.com/flutterchina/dio/issues/30)
      responseType: ResponseType.plain,
      contentType: ContentType.parse(contentType),

      /// headers
      headers: header,

      /// 共同的参数可以在此设置
      queryParameters: queryParameters,
    );

    _dio = Dio(options);

    /// 添加拦截器
    if (Config.DEBUG) {
      _dio.interceptors
        ..add(InterceptorsWrapper(onRequest: (RequestOptions options) {
          print("\n================== 请求数据 ==========================");
          print("url = ${options.uri.toString()}");
          print("headers = ${options.headers}");
          print("params = ${options.data}");
        }, onResponse: (Response response) {
          print("\n================== 响应数据 ==========================");
          print("code = ${response.statusCode}");
          print("data = ${response.data}");
          print("\n");
        }, onError: (DioError e) {
          print("\n================== 错误响应数据 ======================");
          print("type = ${e.type}");
          print("message = ${e.message}");
          print("stackTrace = ${e.stackTrace}");
          print("\n");
        }))

        /// 添加 LogInterceptor 拦截器来自动打印请求、响应日志
        ..add(LogInterceptor(responseBody: false));
    }
  }

  // get
  get(path, {data, options, cancelToken}) async {
    print('get请求启动! path：$path ,body: $data');
    Response response;
    try {
      response = await _dio.get(
        /// 请求路径，如果 `path` 以 "http(s)"开始, 则 `baseURL` 会被忽略； 否则, 将会和baseUrl拼接出完整的的url.
        path,
        queryParameters: data,
        cancelToken: cancelToken,
        onReceiveProgress: (int count, int total) {
          print(
              'onReceiveProgress: ${(count / total * 100).toStringAsFixed(0)} %');
        },
      );

      /// 响应数据，可能已经被转换了类型, 详情请参考Options中的[ResponseType].
      print('get请求成功!response.data：${response.data}');

      /// 响应头
      print('get请求成功!response.headers：${response.headers}');

      /// 本次请求信息
      print('get请求成功!response.request：${response.request}');

      /// Http status code.
      print('get请求成功!response.statusCode：${response.statusCode}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        /// 错误描述
        print('get请求取消! ' + e.message);
      }

      /// 响应信息, 如果错误发生在在服务器返回数据之前，它为 `null`
      print('get请求发生错误：${e.response}');

      response = e.response;
    }
    return response;
  }

  // post
  post(path, {data, options, cancelToken}) async {
    print('post请求启动! path：$path ,body: $data');
    Response response;
    try {
      response = await _dio.post(
        /// 请求路径，如果 `path` 以 "http(s)"开始, 则 `baseURL` 会被忽略； 否则, 将会和baseUrl拼接出完整的的url.
        path,
        data: data,
        onSendProgress: (int count, int total) {
          print(
              'onSendProgress: ${(count / total * 100).toStringAsFixed(0)} %');
        },
        onReceiveProgress: (int count, int total) {
          print(
              'onReceiveProgress: ${(count / total * 100).toStringAsFixed(0)} %');
        },
      );
      print('post请求成功!response.data：${response.data}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('post请求取消! ' + e.message);
      }
      print('post请求发生错误：$e');
    }
    return response;
  }

  download(path, savePath) async {
    print('download请求启动! path：$path');
    Response response;
    try {
      response = await _dio.download(
        path,
        savePath,
        onReceiveProgress: (int count, int total) {
          print(
              'onReceiveProgress: ${(count / total * 100).toStringAsFixed(0)} %');
        },
      );
    } on DioError catch (e) {
      print(e.response.toString());
    }

    return response;
  }
}
