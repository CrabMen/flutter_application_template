import 'package:flutter/material.dart';
import 'package:flutter_application_template/app.dart';
import 'package:flutter_application_template/base/base_page.dart';
import 'package:get/get.dart';

import '../../app/app_router.dart';


class MyPage extends BasePage {

  @override
  String get navigatorTitle => "我的";

  @override
  Widget buildBody(BuildContext context) {
    return Stack(children: [
      Positioned(top:20,right:20,child: GestureDetector(child: Icon(Icons.settings),
          onTap: () => Get.toNamed(AppRouter.settingPage))),
      Positioned(top:100,right:20,child: GestureDetector(child: Icon(Icons.feedback),
          onTap: () => Get.toNamed(AppRouter.feedbackPage)))
    ]);

  }
}

