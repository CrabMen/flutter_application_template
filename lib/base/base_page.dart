import 'package:flutter/material.dart';
import 'package:flutter_application_template/pages/login/login_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

abstract class BasePage<T> extends StatelessWidget {
  BasePage({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();

  /// 状态栏高度
  double statusBarH = ScreenUtil().statusBarHeight;

  /// 导航栏高度
  double navBarH = AppBar().preferredSize.height;

  /// 安全区域高度
  double safeBarH = ScreenUtil().bottomBarHeight;

  final String? tag = null;

  T get controller => GetInstance().find<T>(tag: tag)!;

  ///左侧抽屉
  Widget? drawer;

  /// 设置背景颜色
  Color bodyColor = Colors.white;

  /// 是否隐藏导航栏
  bool navigatorHidden = false;

  /// 设置导航栏颜色
  Color? navigatorColor;

  /// 设置标题文字
  String navigatorTitle = '';

  /// 设置左边按钮
  Widget? leading;

  /// 设置左边宽度
  double? leadingWidth;

  /// 设置右边按钮数组
  List<Widget>? rightActions;

  /// 设置主主视图内容(子类不实现会报错)
  Widget buildBody(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: bodyColor,
        drawer: drawer,
        appBar: navigatorHidden
            ? null
            : AppBar(
                backgroundColor: navigatorColor,
                title: Text(navigatorTitle),
                centerTitle: true,
                leading: leading,
                leadingWidth: leadingWidth,
                actions: rightActions,
              ),
        body: buildBody(context));
  }
}
