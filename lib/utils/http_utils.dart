import 'package:dio/dio.dart';
import 'package:flutter_app/global/api.dart';
import 'package:flutter_app/utils/log_util.dart';

class HttpUtils {
  static HttpUtils instance;
  Dio _dio;
  BaseOptions options;

  static HttpUtils getInstance() {
    LogUtil.v('getInstance');
    if (instance == null) {
      instance = HttpUtils();
    }
    return instance;
  }

  HttpUtils() {
    LogUtil.v('dio赋值');

    /// 或者通过传递一个 `options`来创建dio实例
    options = BaseOptions(
      /// 请求基地址,可以包含子路径，如: "https://www.google.com/api/".
      baseUrl: Api.MOVIE_BASE_URL,

      /// 连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,

      /// 接收数据的总时限.
      receiveTimeout: 3000,

      headers: {},
    );
    _dio = Dio(options);

    /// 添加 LogInterceptor 拦截器来自动打印请求、响应日志
    /// 开启请求日志
    _dio.interceptors.add(LogInterceptor(responseBody: false));
  }

  get(path, {data, options, cancelToken}) async {
    LogUtil.v('get请求启动! path：$path ,body: $data');
    Response response;
    try {
      response = await _dio.get(
        /// 请求路径，如果 `path` 以 "http(s)"开始, 则 `baseURL` 会被忽略； 否则, 将会和baseUrl拼接出完整的的url.
        path,
        queryParameters: data,
        cancelToken: cancelToken,
        onReceiveProgress: (int count, int total) {
          LogUtil.v(
              'onReceiveProgress: ${(count / total * 100).toStringAsFixed(0)} %');
        },
      );

      /// 响应数据，可能已经被转换了类型, 详情请参考Options中的[ResponseType].
      LogUtil.v('get请求成功!response.data：${response.data}');

      /// 响应头
      LogUtil.v('get请求成功!response.headers：${response.headers}');

      /// 本次请求信息
      LogUtil.v('get请求成功!response.request：${response.request}');

      /// Http status code.
      LogUtil.v('get请求成功!response.statusCode：${response.statusCode}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        /// 错误描述
        LogUtil.v('get请求取消! ' + e.message);
      }

      /// 响应信息, 如果错误发生在在服务器返回数据之前，它为 `null`
      LogUtil.e('get请求发生错误：${e.response}');
    }
    return response;
  }

  post(path, {data, options, cancelToken}) async {
    LogUtil.v('post请求启动! path：$path ,body: $data');
    Response response;
    try {
      response = await _dio.post(
        /// 请求路径，如果 `path` 以 "http(s)"开始, 则 `baseURL` 会被忽略； 否则, 将会和baseUrl拼接出完整的的url.
        path,
        data: data,
        cancelToken: cancelToken,
        onSendProgress: (int count, int total) {
          LogUtil.v(
              'onSendProgress: ${(count / total * 100).toStringAsFixed(0)} %');
        },
        onReceiveProgress: (int count, int total) {
          LogUtil.v(
              'onReceiveProgress: ${(count / total * 100).toStringAsFixed(0)} %');
        },
      );
      LogUtil.v('post请求成功!response.data：${response.data}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        LogUtil.v('post请求取消! ' + e.message);
      }
      LogUtil.e('post请求发生错误：$e');
    }
    return response;
  }

  download(path, savePath) async {
    LogUtil.v('download请求启动! path：$path');
    Response response;
    try {
      response = await _dio.download(
        path,
        savePath,
        onReceiveProgress: (int count, int total) {
          LogUtil.v(
              'onReceiveProgress: ${(count / total * 100).toStringAsFixed(0)} %');
        },
      );
    } on DioError catch (e) {
      LogUtil.e(e.response.toString());
    }

    return response;
  }
}
