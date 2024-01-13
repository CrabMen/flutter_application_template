import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

abstract class BaseListView extends GetView {
  BaseListView({super.key});

  final items = [].obs;
  final page = 1.obs;

  @override
  Widget build(BuildContext context) {
    return CustomMaterialIndicator(
        onRefresh: onRefresh,
        indicatorBuilder: (_, __) {
          return const Icon(Icons.ac_unit, color: Colors.blue, size: 30);
        },
        child: Obx(() => ListView.builder(itemBuilder: itemBuilder)));
  }

  Widget? itemBuilder(BuildContext context, int index);

  Future<void> onRefresh();
}
