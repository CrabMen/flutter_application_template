import 'dart:ui';

import 'package:get/get.dart';

/// 数组中的字符串 尽量 放在build 方法内部
/// 否则切换语言后不生效

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys =>
      {
        'zh_CN': AppLocales.zh_CN,
        'en_EN': AppLocales.en_EN,
      };


  static Map<String, Locale> languagesMap = {
    '中文': const Locale('zh', 'CN'),
    'English':const Locale('en', 'EN'),
    'Japanese':const Locale('ja', 'JP'),
  };

  static Locale locale(String language) {
    return languagesMap[language] ?? languagesMap["中文"]!;
  }

}

//翻译的所有键值
abstract class AppLocaleKeys {
  static const home = 'home';
  static const discovery = 'discovery';
  static const my = 'my';
  static const login = 'login';
  static const logout = 'logout';
  static const language = 'language';
  static const setting = 'setting';
  static const darkMode = 'darkMode';

}

//所有的翻译内容
abstract class AppLocales  {
  static const en_EN = {
    AppLocaleKeys.home: 'Login',
    AppLocaleKeys.discovery: 'Discovery',
    AppLocaleKeys.my: 'Sign-in',
    AppLocaleKeys.login: 'Login',
    AppLocaleKeys.logout: 'Log Out',
    AppLocaleKeys.language: 'language',
    AppLocaleKeys.setting: 'Settings',
    AppLocaleKeys.darkMode: 'Dark Mode',



  };
  static const zh_CN = {
    AppLocaleKeys.home: '首页',
    AppLocaleKeys.discovery: '发现',
    AppLocaleKeys.my: '我的',
    AppLocaleKeys.login: '登录',
    AppLocaleKeys.logout: '退出登录',
    AppLocaleKeys.language: '语言',
    AppLocaleKeys.setting: '设置',
    AppLocaleKeys.darkMode: '暗夜模式',

  };

}
