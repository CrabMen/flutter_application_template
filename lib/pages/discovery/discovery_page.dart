import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_template/app/constants.dart';
import 'package:flutter_application_template/base/base_list_view.dart';
import 'package:flutter_application_template/http/api.dart';
import 'package:flutter_application_template/http/http_utils.dart';
import 'package:flutter_application_template/main.dart';
import 'package:flutter_application_template/models/list_model.dart';
import 'package:flutter_application_template/native/native_channel.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/sockets/src/socket_notifier.dart';
import 'package:logger/logger.dart';

import '../../app/app_router.dart';

class DiscoveryPageController extends GetxController {


}


class DiscoveryPage extends StatelessWidget{

  DiscoveryPageController controller = Get.put(DiscoveryPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Center(child: Text('发现'))),
      body: DiscoveryList(),
    );
  }


}

class DiscoveryList extends BaseListView {
  DiscoveryList({super.key});


  @override
  Widget? itemBuilder(BuildContext context, int index) {
    ListModel model = items.value[index];
    return ListTile(title:Text(model.title),trailing: Text(model.subTitle));
  }

  @override
  Future<void> onRefresh() async {

   Future.delayed(Duration(seconds: 2)).then((value){
    items.clear();
    items.addAll([
      ListModel(title: "你好",subTitle: "你好"),
      ListModel(title: "我好",subTitle: "我好"),
      ListModel(title: "他好",subTitle: "他好"),
    ]);
    finishRefresh();
   });
  }

  @override
  Future<void> onLoad() async {
    logger.i("上拉加载更多");
    Future.delayed(Duration(seconds: 2)).then((value){
      items.add(ListModel(title: "它好", subTitle:"它好"));
      logger.i("数组${items.value.toString()}");
      finishLoad(result: IndicatorResult.noMore);
    });
  }

  @override
  Widget separatorBuilder(BuildContext context, int index) {

    return Divider(height:0.5);



  }





}
