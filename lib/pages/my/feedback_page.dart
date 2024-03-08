import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class FeedbackController extends GetxController {



}

class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(title: Text("意见反馈")),
      body: Column(children: [
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          color: Colors.white,
          height: 300,
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 10,
            maxLength: 500,
            decoration: InputDecoration(hintText: "请输入您遇到的问题或者建议",
            hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),

          ),
        ),
      ]),
    );


  }

}