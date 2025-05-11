import 'package:dss_project/features/ai_assistant/presentation/views/widgets/ai_assitant_view_body.dart';
import 'package:flutter/material.dart';

class AiAssitantView extends StatelessWidget {
  const AiAssitantView({super.key});
  static const routeName = 'aiAssistantView';
  @override
  Widget build(BuildContext context) {
    return chat_screen();
  }
}
