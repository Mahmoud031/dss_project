import 'package:flutter/material.dart';

import 'widgets/tips_and_advice_view_body.dart';

class TipsAndAdviceView extends StatelessWidget {
  const TipsAndAdviceView({super.key});
  static const routeName = 'tips_and_advice';
  @override
  Widget build(BuildContext context) {
    return TipsAndAdviceViewBody();
  }
}