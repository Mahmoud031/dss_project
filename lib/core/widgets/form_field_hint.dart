import 'package:flutter/material.dart';

class FormFieldHint extends StatelessWidget {
  const FormFieldHint({
    super.key,
    required this.hintText,
  });

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: hintText,
      triggerMode: TooltipTriggerMode.tap,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
      child: const Icon(
        Icons.info_outline,
        size: 20,
        color: Colors.black54,
      ),
    );
  }
} 