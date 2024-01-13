import 'package:dio/dio.dart';
import 'package:flutter_application_template/main.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

//辅助配置
import 'http_config.dart';
import 'interceptors.dart';

class HttpRequest {
  // 单例模式使用Http类，
  static final HttpRequest _instance = HttpRequest._internal();

  factory HttpRequest() => _instance;

  static late final Dio dio;

  /// 内部构造方法
  HttpRequest._internal() {
    /// 初始化dio
    dio = Dio(HttpConfig.baseOptions);
    /// 添加各种拦截器
    dio.interceptors.add(CommonParametersInterceptor());
    dio.interceptors.add(TokenInvlidInterceptor());
    dio.interceptors.add(ErrorInterceptor());


  }

  /// 封装request方法
  Future request({
    required String path, //接口地址
    required HttpMethod method, //请求方式
    dynamic data, //数据
    Map<String, dynamic>? queryParameters,
    bool showLoading = true, //加载过程
    bool showErrorMessage = true, //返回数据
  }) async {

    Options options = Options(
      method: method.value,
      headers: HttpConfig.headers,
    );

    try {
      if (showLoading) EasyLoading.show(status: 'loading...');

      Response response = await dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return response.data;
    } finally {
      if (showLoading) EasyLoading.dismiss();
    }
  }
}

enum HttpMethod {
  get,
  post,
  delete,
  put,
  patch,
  head,
}

extension HttpMethodExtension on HttpMethod {
  String get value => toString().split(".").last;
}
