import 'package:dss_project/core/utils/app_images.dart';
import 'package:dss_project/features/ai_assistant/presentation/views/ai_assitant_view.dart';
import 'package:dss_project/features/chat/presentation/views/chat_view.dart';
import 'package:dss_project/features/chat/presentation/views/widgets/chat_view_body.dart';
import 'package:dss_project/features/faq/presentation/views/faq_view.dart';
import 'package:dss_project/features/home/presentation/views/widgets/home_widgets/feature_container.dart';
import 'package:dss_project/features/home/presentation/views/widgets/home_widgets/home_animations.dart';
import 'package:dss_project/features/home/presentation/views/widgets/home_widgets/welcome_section.dart';
import 'package:dss_project/features/tips/presentation/views/tips_and_advice_view.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late HomeAnimations _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _animations = HomeAnimations(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            WelcomeSection(
              imageAnimation: _animations.imageAnimation,
              titleAnimation: _animations.titleAnimation,
              descriptionAnimation: _animations.descriptionAnimation,
            ),
            // Feature Containers
            FeatureContainer(
              title: 'Frequently Asked Questions',
              description:
                  'Find answers to common questions about loans and our system',
              imagePath: AppImages.faqImage,
              backgroundColor: Colors.blue,
              onTap: () {
                Navigator.pushNamed(context, FaqView.routeName);
              },
              animation: _animations.faqAnimation,
            ),
            FeatureContainer(
              title: 'Chat with AI Assistant',
              description:
                  'Get personalized help and answers to your questions',
              imagePath: AppImages.chatbotImage,
              backgroundColor: Colors.purple,
              onTap: () {
                Navigator.pushNamed(context, AiAssitantView.routeName);
              },
              animation: _animations.chatbotAnimation,
            ),
            FeatureContainer(
              title: 'Loan Tips & Advice',
              description: 'Learn how to improve your chances of loan approval',
              imagePath: AppImages.tipsImage,
              backgroundColor: Colors.teal,
              onTap: () {
                Navigator.pushNamed(context, TipsAndAdviceView.routeName);
              },
              animation: _animations.tipsAnimation,
            ),
            FeatureContainer(
              title: 'Check Your Eligibility',
              description: 'Quickly check if you qualify for a loan',
              imagePath: AppImages.eligibilityImage,
              backgroundColor: Colors.green,
              onTap: () {
                Navigator.pushNamed(context, ChatView.routeName);
              },
              animation: _animations.eligibilityAnimation,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
