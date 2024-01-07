import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_application_template/main.dart';
import 'package:flutter_application_template/app/app_router.dart';
class IntroductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(title: 'Page One', bodyWidget: const Text('That\'s all folks')),
        PageViewModel(title: 'Page Two', bodyWidget: const Text('That\'s all folks')),
        PageViewModel(title: 'Page Three', bodyWidget: const Text('That\'s all folks')),
        PageViewModel(
            title: 'Page Four', bodyWidget: const Text('That\'s all folks'))
      ],
      showNextButton: false,
      showDoneButton: false,
      showSkipButton: true,
      skip: Text('Skip'),
      onSkip: (){
        logger.d('点击跳过');
        Get.offAndToNamed(AppRouter.loginPage);
      },
    );
  }
}
