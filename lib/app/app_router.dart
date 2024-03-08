import 'package:flutter/material.dart';
import 'package:flutter_application_template/app/app_binding.dart';
import 'package:flutter_application_template/app/app_life.dart';
import 'package:flutter_application_template/app/app_middlewares.dart';
import 'package:flutter_application_template/app/app_theme.dart';

import 'package:flutter_application_template/pages/home/home_page.dart';
import 'package:flutter_application_template/pages/home/scan_code_page.dart';
import 'package:flutter_application_template/pages/login/login_page.dart';
import 'package:flutter_application_template/pages/login/introduction_page.dart';
import 'package:flutter_application_template/pages/my/feedback_page.dart';

import 'package:flutter_application_template/pages/my/my_page.dart';
import 'package:flutter_application_template/pages/my/setting_page.dart';
import 'package:flutter_application_template/pages/tabNav/tab_navigation_page.dart';
import 'package:get/get.dart';

abstract class AppRouter{

  static  String introductionPage = '/introductionPage';
  static  String loginPage = '/loginPage';
  static  String homePage = '/homePage';
  static  String scanCodePage = '/scanCodePage';

  static  String myPage = '/myPage';
  static  String root = '/root';
  static  String settingPage = '/settingPage';
  static  String feedbackPage = '/feedbackPage';



  //默认的的路由表
  static Map<String,Widget Function(BuildContext)> defaultRoutes = {

    loginPage:(context)=>LoginPage(),
    homePage:(context)=>HomePage(),
    myPage:(context)=>MyPage(),
    root:(context)=>TabNavigationPage(),
  };

  //getx 的路由表
  static List<GetPage> getPages = [
    GetPage(
        name: root,
        page: () => TabNavigationPage(),
        transition: Transition.fade,
    ),

    GetPage(
      name: introductionPage,
      page: () => IntroductionPage(),
      transition: Transition.fade,
    ),
    GetPage(
        name: loginPage,
        page: () => LoginPage(),
        transition: Transition.downToUp,
        middlewares: [IntroductionMiddleware()],
    ),
    GetPage(
        name: homePage,
        page: () => HomePage()
    ),
    GetPage(
      name: scanCodePage,
      page: () => ScanCodePage(),
    ),
    GetPage(
      name: myPage,
      page: () => MyPage(),
    ),
    GetPage(
        name: settingPage,
        page: () => SettingPage(),
        transition: Transition.rightToLeft,
        middlewares: [LoginMiddleware()],
        binding: BindingsBuilder.put(() => AppTheme(),permanent: true),
    ),

    GetPage(
      name: feedbackPage,
      page: () => FeedbackPage(),
    ),


  ];
}
