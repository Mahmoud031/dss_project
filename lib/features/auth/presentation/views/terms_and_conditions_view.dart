import 'package:dss_project/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'widgets/terms_and_conditions_view_body.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({super.key});
  static const routeName = 'termsAndConditionsView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      backgroundColor: AppColors.primaryColor,
      body: TermsAndConditionsViewBody(),
    );
  }
}
