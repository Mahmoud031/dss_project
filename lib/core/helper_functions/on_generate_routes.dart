import 'package:dss_project/features/ai_assistant/presentation/views/ai_assitant_view.dart';
import 'package:dss_project/features/auth/presentation/views/sign_in_view.dart';
import 'package:dss_project/features/auth/presentation/views/sign_up_view.dart';
import 'package:dss_project/features/auth/presentation/views/terms_and_conditions_view.dart';
import 'package:dss_project/features/chat/presentation/views/chat_view.dart';
import 'package:dss_project/features/faq/presentation/views/faq_view.dart';
import 'package:dss_project/features/home/presentation/views/home_view.dart';
import 'package:dss_project/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:dss_project/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';

import '../../features/tips/presentation/views/tips_and_advice_view.dart';


Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) { 
    case SplashView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (_) => const OnBoardingView());
    case SignInView.routeName:
      return MaterialPageRoute(builder: (_) => const SignInView());
    case SignUpView.routeName:
      return MaterialPageRoute(builder: (_) => const SignUpView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (_) => const HomeView());
    case ChatView.routeName:
      return MaterialPageRoute(builder: (_) => const ChatView());
    case TermsAndConditionsView.routeName:
      return MaterialPageRoute(builder: (_) => const TermsAndConditionsView());
    case FaqView.routeName:
      return MaterialPageRoute(builder: (_) => const FaqView());
    case TipsAndAdviceView.routeName:
      return MaterialPageRoute(builder: (_) => const TipsAndAdviceView());
    case AiAssitantView.routeName:
      return MaterialPageRoute(builder: (_) => const AiAssitantView());
    default:
      return MaterialPageRoute(builder: (_) => const SplashView());
  }
}
