import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
class NativeChannel extends GetxController {

  static const platform = MethodChannel('NativeChannel');

  callNativeMethod() async {
    try {
    var params = {'title':'调用原生','content':'原生端显示内容，内容很多 '};
      platform
          .invokeMethod('showAlert', params)
          .then((value) => EasyLoading.showInfo(value.toString()));
    } catch(e){
      print('Error calling native method: $e');
    }
    
  }
  
}