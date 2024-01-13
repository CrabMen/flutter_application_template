import 'package:flutter/material.dart';
import 'package:flutter_application_template/app/constants.dart';
import 'package:flutter_application_template/base/base_list_view.dart';
import 'package:flutter_application_template/http/api.dart';
import 'package:flutter_application_template/http/http_utils.dart';
import 'package:flutter_application_template/native/native_channel.dart';
import 'package:get/get.dart';

import '../../app/app_router.dart';

class DiscoveryPageController extends GetxController {

}


class DiscoveryPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title:const Center(child: Text('发现'))),
      // body: Container(
      //     alignment: Alignment.center,
      //     child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      //       const SizedBox(height: 20),
      //     ])),
      body: DiscoveryList(),
    );
  }


}

class DiscoveryList extends BaseListView {
  DiscoveryList({super.key});

  @override
  Widget? itemBuilder(BuildContext context, int index) {
    return Container(height: 50,child: Text('第$index个'));
  }

  @override
  Future<void> onRefresh() async {
    Future.delayed(Duration(seconds: 2)).then((value){
      items.value = ["你好","我好","他好"];
    });
  }





}
