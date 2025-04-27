import 'package:dss_project/constants.dart';
import 'package:dss_project/core/services/shared_preferences_singleton.dart';
import 'package:dss_project/features/auth/presentation/views/sign_in_view.dart';
import 'package:dss_project/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:flutter/material.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    executeNavigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Image(
          image: AssetImage('assets/images/loginImages/logo.png'),
          height: 295,
          width: 290),
    );
  }

  void executeNavigation() {
    bool isOnBoardingViewSeen = Prefs.getBool(kIsOnBoardingViewSeen);
    Future.delayed(const Duration(seconds: 1), () {
      if (isOnBoardingViewSeen) {
        Navigator.pushReplacementNamed(context, SignInView.routeName);
      } else {
        Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
      }
    });
  }
}
