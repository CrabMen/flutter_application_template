import 'package:dio/dio.dart';

class HttpConfig {
  static final baseOptions = BaseOptions(
      contentType: Headers.formUrlEncodedContentType,
      connectTimeout: const Duration(seconds: 3),
      receiveTimeout: const Duration(seconds: 3),
      sendTimeout: const Duration(seconds: 3),
      responseType: ResponseType.json,
      baseUrl: "https://api-shanqian.gengguangcj.cn/",
      // baseUrl: "https://www.baidu.com/"
      // headers: headers,
  );

  static final headers = <String,dynamic>{'':''};


}


