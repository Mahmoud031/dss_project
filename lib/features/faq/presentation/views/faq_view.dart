import 'package:flutter/material.dart';

import 'faq_widgets/faq_view_body.dart';

class FaqView extends StatelessWidget {
  const FaqView({super.key});
  static const routeName = 'faq';
  @override
  Widget build(BuildContext context) {
    return FaqViewBody();
  }
}
