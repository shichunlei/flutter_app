import 'dart:convert';

import 'package:flutter/material.dart';

import '../page_index.dart';

class HttpUtils {
  /// http request methods
  static const String GET = 'get';
  static const String POST = 'post';
  static const String DELETE = 'delete';

  Dio _dio;

  CancelToken cancelToken = CancelToken();

  Dio get dio => _dio;

  HttpUtils({String baseUrl: ApiUrl.BASE_URL, Map<String, dynamic> headers}) {
    Log.d('dio赋值=====$baseUrl');

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

      /// Http请求头.
      // headers: headers ?? {"Content-Type": "application/x-www-form-urlencoded"},
    );

    _dio = Dio(options);

    /// 添加拦截器
    _dio.interceptors
      ..add(InterceptorsWrapper(
        /// 请求时的处理
        onRequest: (RequestOptions options, handler) {
          Log.d("\n================== 请求数据 ==========================");
          Log.d("url = ${options.uri.toString()}");
          Log.d("data = ${options.data}");
          Log.d("queryParameters = ${options.queryParameters}");
          Log.d("method = ${options.method}");

          options.headers
            ..addAll({
              "version": "1.0.0",
              // 可以把token等放到这儿
            });

          Log.d("headers = ${options.headers}");

          return handler.next(options);
        },

        /// 响应时的处理
        onResponse: (Response response, handler) {
          Log.d("\n================== 响应数据 ==========================");
          Log.d("code = ${response.statusCode}");
          Log.d("data = ${response.data}");
          Log.d("\n");
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          Log.d("\n================== 错误响应数据 ======================");
          Log.d("type = ${e.type}");
          Log.d("error = ${e.error}");
          Log.d("message = ${e.message}");
          Log.d("\n");
          return handler.next(e);
        },
      ))

      /// 添加 LogInterceptor 拦截器来自动打印请求、响应日志
      ..add(LogInterceptor(
        request: false,
        responseBody: true,
        responseHeader: false,
        requestHeader: false,
      ));
  }

  /// Make http request with options.
  ///
  /// [method] The request method.
  /// [path] The url path.
  /// [data] The request data
  ///
  /// String 返回 json data .
  Future<Response> request(
    String path, {
    Map<String, dynamic> data,
    String method: GET,
    CancelToken cancelToken,
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

    Response response;
    try {
      response = await dio.request(

          /// 请求路径，如果 `path` 以 "http(s)"开始, 则 `baseURL` 会被忽略； 否则, 将会和baseUrl拼接出完整的的url.
          path,
          data: data != null ? FormData.fromMap(data) : null,
          queryParameters: data,
          options: Options(method: method), onReceiveProgress: (int count, int total) {
        Log.d('onReceiveProgress: ${(count / total * 100).toStringAsFixed(0)} %');
      }, onSendProgress: (int count, int total) {
        Log.d('onSendProgress: ${(count / total * 100).toStringAsFixed(0)} %');
      }, cancelToken: cancelToken);
    } on DioError catch (e) {
      formatError(e);

      /// 响应信息, 如果错误发生在在服务器返回数据之前，它为 `null`
      Log.d('$method请求发生错误：${e.response}');
    }

    return response;
  }

  Future<Response> download(url, savePath,
      {Function(int count, int total) onReceiveProgress, CancelToken cancelToken}) async {
    Log.d('download请求启动! url：$url');
    Response response;
    try {
      response =
          await Dio().download(url, savePath, cancelToken: cancelToken, onReceiveProgress: (int count, int total) {
        Log.d('onReceiveProgress: ${(count / total * 100).toStringAsFixed(0)} %');

        onReceiveProgress(count, total);
      });
    } on DioError catch (e) {
      Log.d(e.response.toString());
      formatError(e);
    }

    return response;
  }

  /// 上传文件
  ///
  /// [path] The url path.
  /// [data] The request data
  ///
  Future<Response> uploadFile(String path, {String baseUrl = ApiUrl.BASE_URL, @required FormData data}) async {
    /// 打印请求相关信息：请求地址、请求方式、请求参数
    Log.d("请求地址：【$baseUrl$path】");
    Log.d('请求参数：' + data.toString());
    Response response;
    try {
      response = await Dio(
        BaseOptions(baseUrl: baseUrl, connectTimeout: 15000, receiveTimeout: 15000),
      ).post("$path", data: data, onReceiveProgress: (int count, int total) {
        Log.d('onReceiveProgress: ${(count / total * 100).toStringAsFixed(0)} %');
      }, onSendProgress: (int count, int total) {
        Log.d('onSendProgress: ${(count / total * 100).toStringAsFixed(0)} %');
      });

      /// 响应数据，可能已经被转换了类型, 详情请参考Options中的[ResponseType].
      Log.d('请求成功!response.data：${response.data}');

      /// 响应头
      Log.d('请求成功!response.headers：${response.headers}');

      /// Http status code.
      Log.d('请求成功!response.statusCode：${response.statusCode}');
    } on DioError catch (e) {
      Log.d(e.response.toString());
      formatError(e);
    }

    return response;
  }

  /// error统一处理
  void formatError(DioError e) {
    if (e.type == DioErrorType.connectTimeout) {
      // It occurs when url is opened timeout.
      Log.d("连接超时 Ծ‸ Ծ");
    } else if (e.type == DioErrorType.sendTimeout) {
      // It occurs when url is sent timeout.
      Log.d("请求超时 Ծ‸ Ծ");
    } else if (e.type == DioErrorType.receiveTimeout) {
      //It occurs when receiving timeout
      Log.d("响应超时 Ծ‸ Ծ");
    } else if (e.type == DioErrorType.response) {
      // When the server response, but with a incorrect status, such as 404, 503...
      Log.d("出现异常 Ծ‸ Ծ");
    } else if (e.type == DioErrorType.cancel) {
      // When the request is cancelled, dio will throw a error with this type.
      Log.d("请求取消 Ծ‸ Ծ");
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      Log.d("未知错误 Ծ‸ Ծ");
    }
  }

  /// 取消请求
  ///
  /// 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。所以参数可选
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  get(String path, Function successCallBack,
      {Map<String, dynamic> params,
      CancelToken cancelToken,
      Function(Map error) errorCallBack,
      bool useBaseResult: true}) async {
    _requestHttp(path, successCallBack,
        method: GET,
        params: params,
        errorCallBack: errorCallBack,
        cancelToken: cancelToken,
        useBaseResult: useBaseResult);
  }

  post(String path, Function successCallBack,
      {Map<String, dynamic> params,
      CancelToken cancelToken,
      Function(Map error) errorCallBack,
      bool useBaseResult: true}) async {
    _requestHttp(path, successCallBack,
        method: POST,
        params: params != null ? FormData.fromMap(params) : null,
        errorCallBack: errorCallBack,
        cancelToken: cancelToken,
        useBaseResult: useBaseResult);
  }

  delete(String path, Function successCallBack,
      {Map<String, dynamic> params,
      CancelToken cancelToken,
      Function(Map error) errorCallBack,
      bool useBaseResult: true}) async {
    _requestHttp(path, successCallBack,
        method: DELETE,
        params: params,
        errorCallBack: errorCallBack,
        cancelToken: cancelToken,
        useBaseResult: useBaseResult);
  }

  _requestHttp(String path, Function successCallBack,
      {@required String method,
      dynamic params,
      Function(Map error) errorCallBack,
      CancelToken cancelToken,
      bool useBaseResult}) async {
    Response response;
    try {
      if (method == GET) {
        if (null != params && params.isNotEmpty) {
          response = await dio.get(path, queryParameters: params, cancelToken: cancelToken);
        } else {
          response = await dio.get(path, cancelToken: cancelToken);
        }
      } else if (method == POST) {
        response = await dio.post(path, data: params, queryParameters: params, onSendProgress: (int count, int total) {
          Log.d('onSendProgress: ${(count / total * 100).toStringAsFixed(0)} %');
        }, cancelToken: cancelToken);
      } else if (method == DELETE) {
        response = await dio.delete(path, queryParameters: params, cancelToken: cancelToken);
      }
    } on DioError catch (error) {
      // 请求错误处理
      Log.d(error.response.toString());
      formatError(error);
      _error(errorCallBack, {"message": error.message});
    }
    if (response != null && response.statusCode >= 200 && response.statusCode < 300) {
      if (useBaseResult) {
        BaseResult result = BaseResult.fromMap(json.decode(response.data));
        if (result == null || result.code != '0') {
          _error(errorCallBack, json.decode(response.data));
        } else if (successCallBack != null) {
          successCallBack(result.data);
        }
      } else {
        successCallBack(json.decode(response.data));
      }
    } else {
      _error(errorCallBack, {"message": response.statusMessage, "code": response.statusCode});
    }
  }

  _error(Function(Map error) errorCallBack, Map map) {
    if (errorCallBack != null) {
      errorCallBack(map);
    }
  }
}
