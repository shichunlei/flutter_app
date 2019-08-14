import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app/global/config.dart';
import 'package:flutter_app/service/api_url.dart';

class HttpUtils {
  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  Dio _dio;
  BaseOptions options;

  get dio => Dio();

  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  HttpUtils({String baseUrl: ApiUrl.MOVIE_BASE_URL}) {
    print('dio赋值=====$baseUrl');

    /// 或者通过传递一个 `options`来创建dio实例
    BaseOptions options = BaseOptions(
      /// 请求基地址,可以包含子路径，如: "https://www.google.com/api/".
      baseUrl: baseUrl,

      /// 连接服务器超时时间，单位是毫秒.
      connectTimeout: 15000,

      /// 接收数据的总时限.
      receiveTimeout: 15000,

      /// [如果返回数据是json(content-type)，dio默认会自动将数据转为json，无需再手动转](https://github.com/flutterchina/dio/issues/30)
      responseType: ResponseType.plain,
      contentType:
          ContentType('application', CONTENT_TYPE_FORM, charset: 'utf-8'),
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
        ..add(LogInterceptor());
    }
  }

  /// request method
  request(String url, {data, method: GET, CancelToken cancelToken}) async {
    if (data != null) {
      /// restful 请求处理
      /// /gysw/search/hist/:user_id        user_id=27
      /// 最终生成 url 为     /gysw/search/hist/27
      data.forEach((key, value) {
        if (url.indexOf(key) != -1) {
          url = url.replaceAll(':$key', value.toString());
        }
      });
    }

    /// 打印请求相关信息：请求地址、请求方式、请求参数
    print('请求地址：【' + method + '  ' + url + '】');
    print('请求参数：' + data.toString());
    Response response;
    try {
      response = await _dio.request(

          /// 请求路径，如果 `path` 以 "http(s)"开始, 则 `baseURL` 会被忽略； 否则, 将会和baseUrl拼接出完整的的url.
          url,
          data: data,
          queryParameters: data,
          options: Options(method: method),
          onReceiveProgress: (int count, int total) {
        print(
            'onReceiveProgress: ${(count / total * 100).toStringAsFixed(0)} %');
      }, onSendProgress: (int count, int total) {
        print('onSendProgress: ${(count / total * 100).toStringAsFixed(0)} %');
      }, cancelToken: cancelToken);

      /// 响应数据，可能已经被转换了类型, 详情请参考Options中的[ResponseType].
      print('$method请求成功!response.data：${response.data}');

      /// 响应头
      print('$method请求成功!response.headers：${response.headers}');

      /// 本次请求信息
      print('$method请求成功!response.request：${response.request}');

      /// Http status code.
      print('$method请求成功!response.statusCode：${response.statusCode}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        /// 错误描述
        print('$method请求取消! ' + e.message);
      }
      response = e.response;

      /// 响应信息, 如果错误发生在在服务器返回数据之前，它为 `null`
      print('$method请求发生错误：${e.response}');
    }

    return response;
  }

  download(url, savePath,
      {Function(int count, int total) onReceiveProgress,
      CancelToken cancelToken}) async {
    print('download请求启动! url：$url');
    Response response;
    try {
      response = await dio.download(
        url,
        savePath,
        cancelToken: cancelToken,
        onReceiveProgress: (int count, int total) {
          print(
              'onReceiveProgress: ${(count / total * 100).toStringAsFixed(0)} %');

          onReceiveProgress(count, total);
        },
      );
    } on DioError catch (e) {
      print(e.response.toString());
    }

    return response;
  }
}
