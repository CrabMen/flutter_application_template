import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_template/models/list_model.dart';
import 'package:get/get.dart';

abstract class BaseListView extends GetView {
  BaseListView({super.key});

  final items = [
    ListModel(title: "你好", subTitle: "你好"),
    ListModel(title: "我好", subTitle: "我好"),
    ListModel(title: "他好", subTitle: "他好"),
  ].obs;
  final page = 1.obs;

  final EasyRefreshController _controller = EasyRefreshController(controlFinishRefresh: true, controlFinishLoad: true);

  finishRefresh(){
    _controller.finishRefresh();
  }

  finishLoad({IndicatorResult result = IndicatorResult.success}) {
    _controller.finishLoad(result);
  }


  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
        controller: _controller,
        onRefresh: (){
          _controller.resetFooter();
          return onRefresh();
        },
        onLoad: onLoad,
        child: Obx(() =>
            ListView.separated(
                itemCount: items.value.length,
                itemBuilder: itemBuilder,
                separatorBuilder: separatorBuilder)));
  }


  Widget separatorBuilder(BuildContext context, int index);

  Widget? itemBuilder(BuildContext context, int index);

  Future<void> onRefresh();

  Future<void> onLoad();
}
