import 'package:flutter/material.dart';
import 'package:flutter_application_template/app/app_translations.dart';
import 'package:flutter_application_template/pages/discovery/discovery_page.dart';
import 'package:flutter_application_template/pages/home/home_page.dart';
import 'package:flutter_application_template/pages/my/my_page.dart';
import 'package:get/get.dart';

class TabNavigationPageController extends GetxController {
  var selectedIndex = 0.obs;


}

class TabNavigationPage extends StatelessWidget {

  final controller = Get.put(TabNavigationPageController());
  List<Widget>pages = [HomePage(),DiscoveryPage(),MyPage()];

  TabNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> titles = [AppLocaleKeys.home.tr,AppLocaleKeys.discovery.tr, AppLocaleKeys.my.tr];
    List<Icon> icons = const [Icon(Icons.home),Icon(Icons.find_in_page), Icon(Icons.person)];

    List<BottomNavigationBarItem> buildItems() {
      return titles
          .asMap()
          .entries
          .map((e) => BottomNavigationBarItem(
                label: e.value,
                icon: icons[e.key],
              )).toList();
    }

    return Obx(() => Scaffold(
          body: pages[controller.selectedIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.selectedIndex.value,
            onTap: (index) {
              controller.selectedIndex.value = index;
            },
            items: buildItems(),
          ),
        ));
  }
}
