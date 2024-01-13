import 'package:dio/dio.dart';
import 'package:flutter_application_template/app/app_router.dart';
import 'package:flutter_application_template/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' hide Response;
// import 'package:connectivity_plus/connectivity_plus.dart';

class CommonParametersInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    Map<String, dynamic> params = options.queryParameters ?? {};

    params["_package"] = "";
    params["_version"] = "";
    options.queryParameters = params;
    // TODO: implement onRequest

    logger.i("方法：${options.method}地址：${options.baseUrl} 请求接口：${options.path} 参数：${params}");

    super.onRequest(options, handler);
  }

}


class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {

    HttpException exception = HttpException.create(err);

    logger.e("返回结果是${exception.message}");

    DioException resoledErr = DioException(
      requestOptions: err.requestOptions,
      response:err.response,
      type: err.type,
      error:exception,
      stackTrace:err.stackTrace,
      message: err.message,
    );


    if(exception.message.isNotEmpty) Fluttertoast.showToast(msg: exception.message);

    super.onError(resoledErr, handler);
  }
}


class TokenInvlidInterceptor  extends Interceptor {
 @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
   logger.i("返回结果是$response");

   String message = response.data["message"] ?? "";

   int code = response.data["code"];

   if(response.data["code"] == 200) {

    if(message.isNotEmpty) Fluttertoast.showToast(msg: message);

   } else if (code == 401) {
     logger.i("返回code是$code");
     Fluttertoast.showToast(msg: "登录已过期");

     Get.toNamed(AppRouter.loginPage);

   } else {

     logger.i("返回code是$code");


   }


   super.onResponse(response, handler);
  }
}



class HttpException implements Exception {
  final int code;
  final String message;

  HttpException({
    this.code = -1,
    this.message = '网络状况不好',
  });

  @override
  String toString() {
    return 'Http Error [$code]: $message';
  }

  factory HttpException.create(DioException error) {

    switch(error.type){

      case DioExceptionType.badResponse:
        return HttpException._create(error);
      case DioExceptionType.cancel:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return HttpException(code: -1,message: error.type.toPrettyDescription());
      default:return HttpException();
    }
  }

  factory HttpException._create(DioException error) {
    int statusCode = error.response?.statusCode ?? -1;
    String message = error.response?.statusMessage ?? "unknow error";
    final Map<int, String> statusCodeMap = {
      400: "Request syntax error",
      401: "Without permission",
      403: "Server rejects execution",
      404: "Unable to connect to server",
      405: "The request method is disabled",
      500: "Server internal error",
      502: "Invalid request",
      503: "The server is down",
      505: "HTTP requests are not supported",
    };

   if (statusCodeMap.keys.contains(statusCode)) return HttpException(code: -1,message: statusCodeMap[statusCode]!);

    return HttpException(code: -1,message: message);

  }

}



extension _DioExceptionTypeExtension on DioExceptionType {
  String toPrettyDescription() {
    switch (this) {
      case DioExceptionType.connectionTimeout:
        return 'connection timeout';
      case DioExceptionType.sendTimeout:
        return 'send timeout';
      case DioExceptionType.receiveTimeout:
        return 'receive timeout';
      case DioExceptionType.badCertificate:
        return 'bad certificate';
      case DioExceptionType.badResponse:
        return 'bad response';
      case DioExceptionType.cancel:
        return 'request cancelled';
      case DioExceptionType.connectionError:
        return 'connection error';
      case DioExceptionType.unknown:
        return 'unknown';
    }
  }
}