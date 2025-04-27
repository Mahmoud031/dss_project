import 'package:dss_project/core/utils/app_images.dart';
import 'package:flutter/material.dart';

class AnimatedHomeImage extends StatefulWidget {
  const AnimatedHomeImage({super.key});

  @override
  State<AnimatedHomeImage> createState() => _AnimatedHomeImageState();
}

class _AnimatedHomeImageState extends State<AnimatedHomeImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double> _fadeAnimation = const AlwaysStoppedAnimation(0.0);
  Animation<double> _scaleAnimation = const AlwaysStoppedAnimation(0.0);

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
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
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
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          height: 250,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.homePageImage),
              fit: BoxFit.contain,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
} 