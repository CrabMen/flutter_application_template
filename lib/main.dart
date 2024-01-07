import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:flutter_application_template/app/app_binding.dart';
import 'package:flutter_application_template/app/app_router.dart';
import 'package:flutter_application_template/app/app_theme.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app_translations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

late SharedPreferences storage;
var logger = Logger();

void main() {



  startApp();
}


void startApp() async {

  WidgetsFlutterBinding.ensureInitialized();

  await _initlize();

  runApp(const MyApp());

}


_initlize() async {


  storage = await SharedPreferences.getInstance();

  _nativeSplash();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // 设置状态栏颜色为透明
    statusBarIconBrightness: Brightness.light, // 设置状态栏图标为浅色
  ));
}

_nativeSplash() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Future.delayed(Duration(seconds: 1), () {
    FlutterNativeSplash.remove();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 667),
        minTextAdapt: true, //用于控制字体大小是否根据系统的“字体大小”辅助选项来进行缩放
        splitScreenMode: true, //是否支持分屏尺寸
        builder: (context, child) {
          return GetMaterialApp(
            initialBinding: AppBinding(),
            translations: AppTranslations(),
            locale: Locale('zh', 'CN'),
            fallbackLocale: Locale('zh', 'CN'),
            themeMode: ThemeMode.light,
            darkTheme: AppTheme.dark,
            theme: AppTheme.light,
            debugShowCheckedModeBanner: true,
            title: 'Flutter Template',
            initialRoute: AppRouter.loginPage,
            getPages: AppRouter.getPages,
            routingCallback: (routing) {},
            builder: EasyLoading.init(),
          );
        });
  }
}
