import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_template/app/constants.dart';
import 'package:flutter_application_template/native/native_channel.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter_application_template/app/app_life.dart';
import 'package:flutter_application_template/app/app_router.dart';
import 'package:flutter_application_template/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';

class LoginPageController extends GetxController {


  var userName = ''.obs;

  var password = ''.obs;


}


class LoginPage extends StatelessWidget {
  final controller = Get.put(LoginPageController());

  var isChecked = false.obs;

  bool get loginEnable =>
      isChecked.value && controller.userName.value.isNotEmpty && controller.password.value.isNotEmpty;

  var counter = 60.obs;

  bool get countDownEnable => counter.value == 60;

  String get countDownText => countDownEnable ? '发送验证码' : '${counter.value}s';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('登录')),
      body: Container(
          color: Colors.white,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAccountView(),
                _buildPasswordView(),
                SizedBox(height: 20),
                _buildPolicyView(),
                SizedBox(height: 20),
                _buildLoginButton(),
                SizedBox(height: 20),
                _buildGuestLoginButton(),
              ]
          )
      ),
    );
  }


  _buildPasswordView() {
    return TextField(
      decoration: InputDecoration(labelText: "密码"),
      style: TextStyle(fontSize: 16),
      keyboardType: TextInputType.phone,
      onChanged: (value) {
        controller.password.value = value;
      },
    );
  }


  _countDown() {
    if (!countDownEnable) return;
    Timer.periodic(Duration(seconds: 1), (timer) {
      counter --;

      if (counter.value == 0) {
        counter.value = 60;
        timer.cancel();
      }
      print('倒计时:${counter}');
    });
  }


  _buildAccountView() {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextField(
          decoration: InputDecoration(labelText: "用户名"),
          style: TextStyle(fontSize: 16),
          keyboardType: TextInputType.phone,
          onChanged: (value) {
            controller.userName.value = value;
          },
        ),
        Obx(() {
          return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:countDownEnable ?  Colors.blue :  Colors.grey,
                padding: EdgeInsets.zero,
                fixedSize: Size(82, 40),
              ),
              onPressed: _countDown,
              child: Text(countDownText, style: TextStyle(color: Colors.white)));
        }),
      ],
    );
  }

  _buildPolicyView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Obx(() {
          return Checkbox(
            side: const BorderSide(color: Colors.blue, width: 2),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: isChecked.value,
            visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity),
            onChanged: (value) {
              isChecked.value = !isChecked.value;
            },
          );
        }),
        RichText(
            text: TextSpan(children: [
              const TextSpan(text: '我已阅读并同意',
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
              TextSpan(
                text: '《xxx用户协议》',
                style: const TextStyle(color: Colors.blue, fontSize: 12),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // EasyLoading.show(status: 'loading');
                    EasyLoading.showToast('点击了用户协议');
                  },
              ),
              const TextSpan(text: '及',
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
              TextSpan(
                text: '《xxx个人信息保护协议》',
                style: const TextStyle(color: Colors.blue, fontSize: 12),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                  EasyLoading.showToast('点击了个人信息保护协议',toastPosition: EasyLoadingToastPosition.bottom);
                  },
              ),
            ])),
      ],
    );
  }

  _buildLoginButton() {
    return Obx(() {
      return ElevatedButton(
          style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(Size(double.maxFinite, 50)),
              backgroundColor: MaterialStateProperty.all(
                  loginEnable ? Colors.blue : Colors.grey)),
          onPressed: () {
            if (loginEnable) {
              EasyLoading.show();
              Future.delayed(Duration(seconds: 2), () async {
                // user = UserModel(name: controller.userName);
                var user = UserModel(
                    name: controller.userName.value,
                    password: controller.password.value,
                    token: 'token');
              storage.setString('user', jsonEncode(user).toString());


                EasyLoading.showSuccess('登录成功');
                Get.offAllNamed(AppRouter.root);
              });
            } else {
              EasyLoading.showError('请输入用户名或密码');
            }
          },
          child: Text('登录'));
    });
  }

  _buildGuestLoginButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: Size(double.maxFinite, 50),
            backgroundColor:Colors.blue),
        onPressed: () {
          Get.offAllNamed(AppRouter.root);
        },
        child: Text('暂不登录 随便看看'));
  }


}
