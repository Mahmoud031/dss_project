import 'package:flutter/material.dart';

abstract class AppColors {
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment(0.50, -0.50),
    end: Alignment(0.50, 1.00),
    colors: [Color(0xFFD6E9E5), Color(0xFF537B72)],
  );
  static const Color primaryColor = Color(0xffB8C9C5);
}
