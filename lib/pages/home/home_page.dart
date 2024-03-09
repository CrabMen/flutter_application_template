import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_template/app/app_router.dart';
import 'package:flutter_application_template/base/base_page.dart';
import 'package:flutter_application_template/http/http_utils.dart';
import 'package:flutter_application_template/main.dart';
import 'package:flutter_application_template/native/native_channel.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class HomePageController extends GetxController {}

class HomePage extends BasePage<HomePageController> {
  HomePage({super.key});

  final native = Get.put(NativeChannel());

  @override
  String get navigatorTitle => "首页";

  @override
  Widget? get drawer {
    List titles = ['标题一', '标题二', '标题三'];
    return Drawer(
      child: ListView.separated(
          itemBuilder: (_, index) => ListTile(
                title: Text(titles[index]),
                onTap: () => scaffoldKey.currentState!.openEndDrawer(),
              ),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: titles.length),
    );
  }

  @override
  Widget? get leading => IconButton(
        icon: const Icon(Icons.smoke_free),
        onPressed: () => scaffoldKey.currentState!.openDrawer(),
      );

  @override
  List<Widget>? get rightActions => [
        PopupMenuButton(
          child: Row(children: [Icon(Icons.add), SizedBox(width: 10)]),
          offset: Offset(0, 50),
          itemBuilder: (_) => [
            const PopupMenuItem(child: Text('扫一扫'), value: "扫一扫"),
          ],
          onSelected: (value) {
            Get.toNamed(AppRouter.scanCodePage);
          },
        ),
      ];

  @override
  Widget buildBody(BuildContext context) {
    Get.put(HomePageController());

    var noticeView = Container(
      height: 40,
      child: Row(
        children: [
          Text('【温馨提示】'),
          Expanded(
              child: Marquee(text: '本项目主要开发主要用于平台用户交流，如果您有更好的方案可以issue我，共同进步')),
        ],
      ),
    );

    var bannerView = CarouselSlider.builder(
        itemCount: 10,
        itemBuilder: (_, int itemIndex, __) => Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(8)),
            child: Center(child: Text('第 $itemIndex页'))),
        options: CarouselOptions(
          enlargeCenterPage: true,
          enlargeFactor: 0.2,
          height: 200.0,
          autoPlayInterval: Duration(seconds: 2),
          autoPlay: true,
        ));

    var nativeMethodWidtget = ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(300, 50), backgroundColor: Colors.red),
        onPressed: () {
          native.callNativeMethod();
        },
        child: const Text('调用原生方法'));

    var requestWidtget = ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(300, 50), backgroundColor: Colors.green),
        onPressed: () {
          HttpUtils.get(path: 'v2/user/check');
        },
        child: const Text('网络请求'));

    return Column(children: [
      noticeView,
      bannerView,
      const SizedBox(height: 20),
      nativeMethodWidtget,
      const SizedBox(height: 20),
      requestWidtget,
    ]);
  }
}
