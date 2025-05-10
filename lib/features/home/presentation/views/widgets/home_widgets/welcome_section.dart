import 'package:flutter/material.dart';

class WelcomeSection extends StatelessWidget {
  final Animation<double> imageAnimation;
  final Animation<double> titleAnimation;
  final Animation<double> descriptionAnimation;

  const WelcomeSection({
    super.key,
    required this.imageAnimation,
    required this.titleAnimation,
    required this.descriptionAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        // Welcome Image
        FadeTransition(
          opacity: imageAnimation,
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/homePageImage.png'),
                fit: BoxFit.contain,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        const SizedBox(height: 30),
        // Title
        FadeTransition(
          opacity: titleAnimation,
          child: const Text(
            'Welcome to our Loan Prediction System',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 15),
        // Description
        FadeTransition(
          opacity: descriptionAnimation,
          child: const Text(
            'Our advanced AI system helps you predict loan approval chances based on various factors. Get instant insights and make informed financial decisions.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
