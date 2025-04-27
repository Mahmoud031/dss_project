import 'package:dss_project/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class AnimatedHomeButton extends StatefulWidget {
  const AnimatedHomeButton({super.key});

  @override
  State<AnimatedHomeButton> createState() => _AnimatedHomeButtonState();
}

class _AnimatedHomeButtonState extends State<AnimatedHomeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double> _fadeAnimation = const AlwaysStoppedAnimation(0.0);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: CustomButton(
        onPressed: () {},
        text: 'Let`s chat',
        size: const Size(200, 60),
      ),
    );
  }
} 