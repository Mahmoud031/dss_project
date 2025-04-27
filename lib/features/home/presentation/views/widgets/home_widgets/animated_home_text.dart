import 'package:flutter/material.dart';

class AnimatedHomeText extends StatefulWidget {
  const AnimatedHomeText({super.key});

  @override
  State<AnimatedHomeText> createState() => _AnimatedHomeTextState();
}

class _AnimatedHomeTextState extends State<AnimatedHomeText>
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
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
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
    return Column(
      children: [
        FadeTransition(
          opacity: _fadeAnimation,
          child: const Text(
            'Welcome to our Loan Prediction System',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        FadeTransition(
          opacity: _fadeAnimation,
          child: const Text(
            'Our advanced AI system helps you predict loan approval chances based on various factors. Get instant insights and make informed financial decisions.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
} 