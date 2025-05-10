import 'package:flutter/material.dart';

class HomeAnimations {
  final AnimationController controller;
  late final Animation<double> imageAnimation;
  late final Animation<double> titleAnimation;
  late final Animation<double> descriptionAnimation;
  late final Animation<double> faqAnimation;
  late final Animation<double> chatbotAnimation;
  late final Animation<double> tipsAnimation;
  late final Animation<double> eligibilityAnimation;

  HomeAnimations(this.controller) {
    _initializeAnimations();
  }

  void _initializeAnimations() {
    imageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.2, curve: Curves.easeOut),
      ),
    );

    titleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.2, 0.4, curve: Curves.easeOut),
      ),
    );

    descriptionAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.4, 0.6, curve: Curves.easeOut),
      ),
    );

    faqAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.6, 0.7, curve: Curves.easeOut),
      ),
    );

    chatbotAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.7, 0.8, curve: Curves.easeOut),
      ),
    );

    tipsAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.8, 0.9, curve: Curves.easeOut),
      ),
    );

    eligibilityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.9, 1.0, curve: Curves.easeOut),
      ),
    );
  }
} 