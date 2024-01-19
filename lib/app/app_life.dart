import 'package:flutter/material.dart';
import 'package:flutter_application_template/main.dart';
import 'package:get/get.dart';




class AppLife extends SuperController  {



  @override
  void onResumed(){
    logger.i("应用程序已从后台恢复");
  }

  @override
  void onPaused(){
    logger.i("应用程序已暂停（例如，进入后台）");

  }

  @override
  void onInactive(){
    logger.i("应用程序处于非活动状态（例如，进入后台）");

  }

  @override
  void onDetached(){
    logger.i(" 应用程序已分离、进入到原生（仅适用于iOS和Android ）");


  }

}
