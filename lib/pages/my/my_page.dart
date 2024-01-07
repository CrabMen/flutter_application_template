import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/app_router.dart';


class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              fixedSize: Size(150, 50),
              backgroundColor:Colors.blue),
          onPressed: () {
            Get.toNamed(AppRouter.settingPage);
          },
          child: Text('设置'))),
    );


    return const Center(child: Text('我的'));
  }
}

