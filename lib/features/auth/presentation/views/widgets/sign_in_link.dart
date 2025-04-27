import 'package:dss_project/core/utils/app_text_styles.dart';
import 'package:dss_project/features/auth/presentation/views/sign_in_view.dart';
import 'package:flutter/material.dart';

class SignInLink extends StatelessWidget {
  const SignInLink({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, SignInView.routeName),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Already have an account?',
              style: TextStyles.textstyle14
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w400)),
          const SizedBox(width: 4),
          Text('Sign in',
              style: TextStyles.textstyle14.copyWith(color: Color(0xFF407165))),
        ],
      ),
    );
  }
}
