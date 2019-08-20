import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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

  CancelToken cancelToken = CancelToken();

  Dio get dio => _dio;

  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  HttpUtils({String baseUrl: ApiUrl.MOVIE_BASE_URL}) {
    debugPrint('dio赋值=====$baseUrl');

    /// 或者通过传递一个 `options`来创建dio实例
    BaseOptions options = BaseOptions(
      /// 请求基地址,可以包含子路径，如: "https://www.google.com/api/".
      baseUrl: baseUrl,

      /// 连接服务器超时时间，单位是毫秒.
      connectTimeout: 15000,

      /// 接收数据的总时限.
      receiveTimeout: 15000,

      /// [表示期望以那种格式(方式)接受响应数据。接受四种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`](https://github.com/flutterchina/dio/issues/30)
      responseType: ResponseType.plain,

      /// 请求的Content-Type，默认值是[ContentType.json]. 也可以用ContentType.parse("application/x-www-form-urlencoded")
      contentType:
          ContentType('application', CONTENT_TYPE_FORM, charset: 'utf-8'),

      /// Http请求头.
      headers: {
        //do something
        "version": "1.0.0"
      },
    );

    _dio = Dio(options);

    /// Cookie管理
    _dio.interceptors.add(CookieManager(CookieJar()));

    /// 添加拦截器
    if (Config.DEBUG) {
      _dio.interceptors
        ..add(InterceptorsWrapper(onRequest: (RequestOptions options) {
          debugPrint("\n================== 请求数据 ==========================");
          debugPrint("url = ${options.uri.toString()}");
          debugPrint("headers = ${options.headers}");
          debugPrint("params = ${options.data}");
        }, onResponse: (Response response) {
          debugPrint("\n================== 响应数据 ==========================");
          debugPrint("code = ${response.statusCode}");
          debugPrint("data = ${response.data}");
          debugPrint("\n");
        }, onError: (DioError e) {
          debugPrint("\n================== 错误响应数据 ======================");
          debugPrint("type = ${e.type}");
          debugPrint("message = ${e.message}");
          debugPrint("stackTrace = ${e.stackTrace}");
          debugPrint("\n");
        }))

        /// 添加 LogInterceptor 拦截器来自动打印请求、响应日志
        ..add(LogInterceptor());
    }
  }

  /// Make http request with options.
  ///
  /// [method] The request method.
  /// [path] The url path.
  /// [data] The request data
  /// [options] The request options.
  ///
  /// String 返回 json data .
  request(
    String path, {
    data,
    method: GET,
    CancelToken cancelToken,
    Options options,
  }) async {
    if (data != null) {
      /// restful 请求处理
      /// /gysw/search/hist/:user_id        user_id=27
      /// 最终生成 url 为     /gysw/search/hist/27
      data.forEach((key, value) {
        if (path.indexOf(key) != -1) {
          path = path.replaceAll(':$key', value.toString());
        }
      });
    }

    /// 打印请求相关信息：请求地址、请求方式、请求参数
    debugPrint('请求地址：【' + method + '  ' + path + '】');
    debugPrint('请求参数：' + data.toString());
    Response response;
    try {
      response = await dio.request(

          /// 请求路径，如果 `path` 以 "http(s)"开始, 则 `baseURL` 会被忽略； 否则, 将会和baseUrl拼接出完整的的url.
          path,
          data: data,
          queryParameters: data,
          options: _checkOptions(method, options),
          onReceiveProgress: (int count, int total) {
        debugPrint(
            'onReceiveProgress: ${(count / total * 100).toStringAsFixed(0)} %');
      }, onSendProgress: (int count, int total) {
        debugPrint(
            'onSendProgress: ${(count / total * 100).toStringAsFixed(0)} %');
      }, cancelToken: cancelToken);

      /// 响应数据，可能已经被转换了类型, 详情请参考Options中的[ResponseType].
      debugPrint('$method请求成功!response.data：${response.data}');

      /// 响应头
      debugPrint('$method请求成功!response.headers：${response.headers}');

      /// 本次请求信息
      debugPrint('$method请求成功!response.request：${response.request}');

      /// Http status code.
      debugPrint('$method请求成功!response.statusCode：${response.statusCode}');
    } on DioError catch (e) {
      formatError(e);

      /// 响应信息, 如果错误发生在在服务器返回数据之前，它为 `null`
      debugPrint('$method请求发生错误：${e.response}');
    }

    return response;
  }

  download(url, savePath,
      {Function(int count, int total) onReceiveProgress,
      CancelToken cancelToken}) async {
    debugPrint('download请求启动! url：$url');
    Response response;
    try {
      response = await dio.download(
        url,
        savePath,
        cancelToken: cancelToken,
        onReceiveProgress: (int count, int total) {
          debugPrint(
              'onReceiveProgress: ${(count / total * 100).toStringAsFixed(0)} %');

          onReceiveProgress(count, total);
        },
      );
    } on DioError catch (e) {
      debugPrint(e.response.toString());
      formatError(e);
    }

    return response;
  }

  /// check Options.
  Options _checkOptions(method, options) {
    if (options == null) {
      options = Options();
    }
    options.method = method;
    return options;
  }

  /// error统一处理
  void formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      // It occurs when url is opened timeout.
      debugPrint("连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      // It occurs when url is sent timeout.
      debugPrint("请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      //It occurs when receiving timeout
      debugPrint("响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      debugPrint("出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      debugPrint("请求取消");
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      debugPrint("未知错误");
    }
  }

  /// 取消请求
  ///
  /// 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。所以参数可选
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }
}
