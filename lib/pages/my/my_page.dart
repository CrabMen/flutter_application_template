import 'package:flutter/material.dart';
import 'package:flutter_application_template/app.dart';
import 'package:get/get.dart';

import '../../app/app_router.dart';


class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Center(child:Text('我的'))),
      body: Stack(children: [
      Positioned(top:20,right:20,child: GestureDetector(child: Icon(Icons.settings),
        onTap: () => Get.toNamed(AppRouter.settingPage)))

      ]),
      // body: Container(
      //     alignment: Alignment.center,
      //     child: ElevatedButton(
      //     style: ElevatedButton.styleFrom(
      //         fixedSize: Size(150, 50),
      //         backgroundColor:Colors.blue),
      //     onPressed: () {
      //       Get.toNamed(AppRouter.settingPage);
      //     },
      //     child: Text('设置'))),
    );

  }
}

