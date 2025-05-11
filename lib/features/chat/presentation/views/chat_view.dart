import 'package:dss_project/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'widgets/chat_view_body.dart';
 
class ChatView extends StatelessWidget {
  const ChatView({super.key});
  static const routeName = 'chatView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: ChatViewBody(),
    );
  }
}
