import 'package:get/get.dart';
import 'package:flutter_application_template/app/app_life.dart';
import 'package:flutter_application_template/app/app_theme.dart';

class AppBinding extends Bindings {

  @override
  void dependencies() {
    Get.put(AppLife());
    Get.put(AppTheme());

  }

}