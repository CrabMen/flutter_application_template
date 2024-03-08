import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_application_template/app/app_life.dart';
import 'package:flutter_application_template/app/app_theme.dart';
import '../../app/app_translations.dart';
import 'package:flutter_application_template/app/app_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SettingPageController extends GetxController {

  var isLogged = false.obs;



}

class SettingPage extends StatelessWidget {

final AppTheme appTheme = Get.put(AppTheme());
final SettingPageController settingController = Get.put(SettingPageController());


  @override
  Widget build(BuildContext context) {

    _showThemeSheet(){

      Get.bottomSheet(BottomSheet(
        constraints: const BoxConstraints(maxHeight: 200),
        onClosing: () {},
        builder: (context) =>
            ListView.separated(
                itemCount: appTheme.themeNames.length,
                itemBuilder: (context, index) =>
                    ListTile(title: Text(appTheme.themeNames[index]), onTap: () {
                      appTheme.themeMode.value = AppThemeMode.values[index];
                      Get.back();
                    },),
                separatorBuilder: (context, index) =>
                const Divider(color: Colors.grey, height: 1)),
      ));


    }

    return Scaffold(
        appBar:
            AppBar(title: Text(AppLocaleKeys.setting.tr), centerTitle: true),
        body: ListView(children: [
          ListTile(
            title: Text(AppLocaleKeys.language.tr),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: _showLanguagesSheet,
          ),
          Obx(() {
            return ListTile(
              title: Text(AppLocaleKeys.darkMode.tr),
              subtitle: Text(appTheme.themeName.value),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: _showThemeSheet,
            );
          }),

          ListTile(
            title: Text('应用信息'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: _showAppInfo,
          ),

          ListTile(
            title: Text('设备信息'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: _showDeviceInfo,
          ),
          Obx(() => Offstage(
                offstage: !settingController.isLogged.value,
                child: ListTile(
                  title: Text(AppLocaleKeys.logout.tr),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: _logout,
                ),
              )),

         Align(child: QrImage(data: "flutter_application_template",size: 200.w)) ,
        ]));
  }


  _showAppInfo() async{

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    var titles = ['名称','包名','版本','构建版本'];
    var subtitles = [packageInfo.appName,packageInfo.packageName,packageInfo.version,packageInfo.buildNumber];

    var cells = titles.asMap().entries.map((e) =>
        ListTile(title: Text(e.value), trailing: Text(subtitles[e.key],style: TextStyle(color: Colors.grey)))).toList();

    var content = Container(
        height: 220,
        width: double.maxFinite,
        // color: Colors.red,
        child: ListView(
          children: cells,
        ));

    Get.defaultDialog(title: '应用信息',content: content );

  }

  _showDeviceInfo() async{

    var titles = ['设备','Android版本','Android安全更新','是否真机'];
    var subTitles = ['设备','Android版本','Android安全更新','是否真机'];
    final deviceInfo = await DeviceInfoPlugin().deviceInfo;
    if (GetPlatform.isWeb) {
    } else if (GetPlatform.isAndroid) {
      AndroidDeviceInfo androidInfo = deviceInfo as AndroidDeviceInfo;

      subTitles = [
        '${androidInfo.manufacturer} / ${androidInfo.model}',
        androidInfo.version.release,
        androidInfo.version.securityPatch??'',
        androidInfo.isPhysicalDevice ? '真机' :'模拟器',
      ];
    } else if (GetPlatform.isIOS) {
    }
    var cells = titles.asMap().entries.map((e) =>
        ListTile(title: Text(e.value), trailing: Text(subTitles[e.key],style: TextStyle(color: Colors.grey)))).toList();

    var content = Container(
        height: 220,
        width: double.maxFinite,
        // color: Colors.red,
        child: ListView(
          children: cells,
        ));

    Get.defaultDialog(title: '设备信息',content: content);
  }

  _showLanguagesSheet() {
    List languages = AppTranslations.languagesMap.keys.toList();

    Get.bottomSheet(BottomSheet(
      constraints: const BoxConstraints(maxHeight: 200),
      onClosing: () {},
      builder: (context) =>
          ListView.separated(
              itemCount: languages.length,
              itemBuilder: (context, index) =>
                  ListTile(title: Text(languages[index]), onTap: () {
                    _switchLanguage(languages[index]);

                  },),
              separatorBuilder: (context, index) =>
              const Divider(color: Colors.grey, height: 1)),
    ));
  }


  _switchLanguage(String language) {
    EasyLoading.showInfo('切换语言$language');

    Get.updateLocale(AppTranslations.locale(language));

    Get.back();
  }

  _logout() {
    EasyLoading.showInfo('退出登录');

    Get.offAllNamed(AppRouter.loginPage);
  }


}
