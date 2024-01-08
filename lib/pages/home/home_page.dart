import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_template/main.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

class HomePageController extends GetxController {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    var noticeView = Container(
      height: 40,
      child: Row(
        children: [
          Text('【温馨提示】'),
          Expanded(child: Marquee(text: '本项目主要开发主要用于平台用户交流，如果您有更好的方案可以issue我，共同进步')),
        ],
      ),
    );

    var bannerView = CarouselSlider.builder(
        itemCount: 10,
        itemBuilder: (_, int itemIndex, __) => Container(
            width: MediaQuery.of(context).size.width,
            margin:const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(color: Colors.red, borderRadius:BorderRadius.circular(8)),
            child: Center(child: Text('第 $itemIndex页'))),
        options: CarouselOptions(
          enlargeCenterPage:true,
          enlargeFactor:0.2,
          height: 200.0,
          autoPlay: true,
        ));

    List titles = ['标题一','标题二','标题三'];

    var drawer = Drawer(
      child: ListView.separated(
          itemBuilder: (_, index) => ListTile(title: Text(titles[index]),onTap: ()=>controller.closeDrawer(),),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: titles.length),
    );

    return  Scaffold(
      key: controller._scaffoldKey,
      drawer: drawer,
      appBar: AppBar(leading:IconButton(icon:Icon(Icons.smoke_free),onPressed: ()=>controller.openDrawer(),) ,title:const Center(child: Text('首页'))),
      body: Column(children: [
        noticeView,
        bannerView,
      ]),
    );


  }
}
