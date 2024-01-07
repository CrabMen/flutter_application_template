
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_template/app/app_life.dart';
import 'package:flutter_application_template/app/app_router.dart';
import 'package:flutter_application_template/main.dart';
import 'package:flutter_application_template/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginMiddleware extends GetMiddleware {

  @override
  int? priority = 0;

  @override
  //当被调用路由的页面被搜索时，这个函数将被调用。它将RouteSettings作为重定向的结果。或者给它null，就没有重定向了。
  RouteSettings? redirect(String? route) {
    String string = storage.getString('user')?? '';

    UserModel user = UserModel.fromJsonString(string) ;
    print('当前用户token:${user.toJson().toString()}');

    if(user.token.isEmpty) {
      // EasyLoading.showInfo('请先登录');
      // return RouteSettings(name: AppRouter.loginPage);
    }

  }

  //onPageCalled 在调用页面时，创建任何东西之前，这个函数会先被调用。 您可以使用它来更改页面的某些内容或给它一个新页面。
  // GetPage? onPageCalled(GetPage? page) {
  //   final authService = Get.find<AuthService>();
  //   return page?.copyWith(title: 'Welcome ${authService.UserName}');
  // }

//这个函数将在绑定初始化之前被调用。 在这里，您可以更改此页面的绑定。
//   List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
//     final authService = Get.find<AuthService>();
//     if (authService.isAdmin) {
//       bindings?.add(AdminBinding());
//     }
//     return bindings;
//   }

//这个函数将在绑定初始化之后被调用。 在这里，您可以在创建绑定之后和创建页面widget之前执行一些操作。
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {





    return page;
  }

  //这个函数将在GetPage.page调用后被调用，并给出函数的结果，并获取将要显示的widget。
  // Widget onPageBuilt(Widget page) => page;

//这个函数将在处理完页面的所有相关对象(Controllers, views, ...)之后被调用。
//   void onPageDispose() {
//     print('onPageDispose');
//   }

  LoginMiddleware({this.priority});

}

class IntroductionMiddleware extends GetMiddleware {
  @override
  //当被调用路由的页面被搜索时，这个函数将被调用。它将RouteSettings作为重定向的结果。或者给它null，就没有重定向了。
  RouteSettings? redirect(String? route) {

    bool launch = storage.getBool('launch')?? false;

    if(!launch) {
      storage.setBool('launch', true);
      return RouteSettings(name: AppRouter.introductionPage);
    }
  }


}

