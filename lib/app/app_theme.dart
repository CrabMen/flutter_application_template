import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter_application_template/app/app_life.dart';
import 'package:flutter_application_template/main.dart';

//app主题枚举
enum AppThemeMode {
  light,
  dark,
  system,
}

class AppTheme extends GetxController with WidgetsBindingObserver {


  static final AppTheme _instance = AppTheme._init();
  static ThemeData light = ThemeData.light().copyWith();
  static ThemeData dark = ThemeData.dark().copyWith();


  List<String> themeNames = ['浅色模式','深色模式','跟随系统'];

  Rx<AppThemeMode> themeMode = AppThemeMode.light.obs;

  RxBool _isDarkMode = false.obs;


  get themeName => themeNames[themeMode.value.index].obs;

  factory AppTheme() {
    return _instance;
  }

  AppTheme._init(){
    //初始化默认的thememode
    ever(themeMode, (mode){
      if (mode == AppThemeMode.system) {
        Brightness brightness =
            WidgetsBinding.instance.window.platformBrightness;
        _isDarkMode.value = brightness == Brightness.dark;
      } else {
        _isDarkMode.value = mode == AppThemeMode.dark;
      }
      storage.setInt('themeMode', mode.index);
    });

    ever(_isDarkMode, (value) {
      Get.changeTheme(value ? AppTheme.dark : AppTheme.light);
    });



    //从本地读取thememode
    int index = storage.getInt('themeMode') ?? 0;
    themeMode.value = AppThemeMode.values[index];

  }


  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _initListener();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangePlatformBrightness() {
    // TODO: implement didChangePlatformBrightness
    super.didChangePlatformBrightness();

    if (themeMode.value == AppThemeMode.system) {
      Brightness brightness =
          WidgetsBinding.instance.window.platformBrightness;
      _isDarkMode.value = brightness == Brightness.dark;
      logger.d('系统主题发生变化');
    }
  }


  _initListener() {
    return;
    //ever(thememode) 监听多个值变化 用everAll
    EasyLoading.showInfo('当前模式:${themeName}');
    themeMode.listen((mode) {
      logger.d('thememodel变化');
      if (mode == AppThemeMode.system) {
        Brightness brightness =
            WidgetsBinding.instance.window.platformBrightness;
        _isDarkMode.value = brightness == Brightness.dark;
      } else {
        _isDarkMode.value = mode == AppThemeMode.dark;
      }

      storage.setInt('themeMode', mode.index);

    });

    _isDarkMode.listen((e) {
      logger.d('_isDarkMode发生变化');
      Get.changeTheme(e ? AppTheme.dark : AppTheme.light);
    });

  }
}
