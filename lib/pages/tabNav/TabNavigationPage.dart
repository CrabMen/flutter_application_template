import 'package:flutter/material.dart';
import 'package:flutter_application_template/app/app_translations.dart';
import 'package:flutter_application_template/pages/home/home_page.dart';
import 'package:flutter_application_template/pages/my/my_page.dart';
import 'package:get/get.dart';

class TabNavigationPage extends StatefulWidget {
  const TabNavigationPage({Key? key}) : super(key: key);

  @override
  State<TabNavigationPage> createState() => _TabNavigationPageState();
}

class _TabNavigationPageState extends State<TabNavigationPage> {

  var selectedIndex = 0.obs;
  List<Widget>pages = [HomePage(),MyPage()];




  @override
  Widget build(BuildContext context) {

    List<String> titles = [AppLocaleKeys.home.tr,AppLocaleKeys.my.tr];
    List<Icon> icons = [Icon(Icons.home),Icon(Icons.person)];

    _buildItems() {
      return titles.asMap().entries.map((e) => BottomNavigationBarItem(
        label: e.value,
        icon: icons[e.key],
      )).toList();
    }

    return Obx(() => Scaffold(
      body: pages[selectedIndex.value],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex.value,
        onTap: (index) {
          selectedIndex.value = index;
        },
        items: _buildItems(),
      ),
    ));
  }
}
