import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/app_router.dart';

class DiscoveryPageController extends GetxController {

}


class DiscoveryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('发现'))),
      body: Container(
          alignment: Alignment.center,
          child: Text('发现')),
    );


  }
}

