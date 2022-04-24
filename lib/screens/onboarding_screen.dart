import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/widgets/onboarding_widget.dart';

class OnboardingScreen extends StatelessWidget {
  static const routename = '/onboardingscreen';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController();
    return Scaffold(
      resizeToAvoidBottomInset : false,
        body: PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (ctx, index) => OnboardingWidget(
                  pageController: _pageController,
                  screenIndex: index,
                  imgText: 'assets/images/onb${index + 1}img.png',
                )));
  }
}
