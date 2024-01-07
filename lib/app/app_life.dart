import 'package:flutter/material.dart';
import 'package:get/get.dart';




class AppLife extends GetxController with WidgetsBindingObserver {

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }


  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // 应用程序已从后台恢复
    } else if (state == AppLifecycleState.inactive) {
      // 应用程序处于非活动状态（例如，进入后台）
    } else if (state == AppLifecycleState.paused) {
      // 应用程序已暂停（例如，进入后台）
    } else if (state == AppLifecycleState.detached) {
      // 应用程序已分离（仅适用于iOS和Android）
    }
  }


}
