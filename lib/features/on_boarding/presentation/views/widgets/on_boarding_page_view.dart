import 'package:dss_project/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'page_view_item.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return PageView(controller: pageController, children: [
      PageViewItem(
        isVisible: true,
        image: AppImages.onBoardingPageOne,
        title:
            'Easily apply for bank loans by signing up, submitting your details, and sending your request.',
        currentPage: 0,
        pageController: pageController,
      ),
      PageViewItem(
        isVisible: true,
        image: AppImages.onBoardingPageTwo,
        title:
            'Apply for a loan easily. The bank reviews your details and updates your status. Track approvals and payment dates — all in one app.',
        currentPage: 1,
        pageController: pageController,
      ),
    ]);
  }
}
