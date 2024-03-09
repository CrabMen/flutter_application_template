import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_template/base/base_page.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController {}

class FeedbackPage extends BasePage {
  @override
  Color get bodyColor => Colors.white;

  @override
  String get navigatorTitle => "意见反馈";

  @override
  Widget buildBody(BuildContext context) {
    return Column(children: [
      SizedBox(height: 20),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        height: 300,
        child: TextField(
          keyboardType: TextInputType.multiline,
          maxLines: 10,
          maxLength: 500,
          decoration: InputDecoration(
            hintText: "请输入您遇到的问题或者建议",
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
        ),
      ),
    ]);
  }
}
