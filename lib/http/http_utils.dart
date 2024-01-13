import 'package:dio/dio.dart';

import 'http_request.dart';

/// 调用底层的request，重新提供get，post等方便方法

class HttpUtils {
  static HttpRequest httpRequest = HttpRequest();
  /// get
  static Future get({
    required String path,
    Map<String, dynamic>? queryParameters,
    bool showLoading = true,
    bool showErrorMessage = true,
  }) {
    return httpRequest.request(
      path: path,
      method: HttpMethod.get,
      queryParameters: queryParameters,
      showLoading: showLoading,
      showErrorMessage: showErrorMessage,
    );
  }

  /// post
  static Future post({
    required String path,
    dynamic data,
    bool showLoading = true,
    bool showErrorMessage = true,
  }) {
    return httpRequest.request(
      path: path,
      method: HttpMethod.post,
      data: data,
      showLoading: showLoading,
      showErrorMessage: showErrorMessage,
    );
  }

  static Future<void Function(Map timeMap, String fastDomain)> fastDomain(List<String>domains) async{
    Map<String, double> responseTimes = {};

    Dio dio = Dio();

    for (String domain in domains) {
      Response response = await dio.head(domain);
      double responseTime = response.headers.value('x-response-time') as double;
      responseTimes[domain] = responseTime;
    }

    // 根据响应时间排序域名
    domains.sort((a, b) => responseTimes[a]!.compareTo(responseTimes[b]!));

    // 选择最快的域名作为基础URL
    String fastestDomain = domains.first;
    dio.options.baseUrl = fastestDomain;
    return (responseTimes,fastestDomain){};
  }


}