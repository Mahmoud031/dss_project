import 'package:dss_project/core/utils/app_text_styles.dart';
import 'package:dss_project/features/auth/presentation/views/terms_and_conditions_view.dart';
import 'package:flutter/material.dart';

import 'check_box.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key, required this.onChanged});
  final ValueChanged<bool> onChanged;

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.3,
          child: CheckBox(
            value: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value ?? false;
              });
              widget.onChanged(isChecked);
            },
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: GestureDetector(
            onTap: (){
              Navigator.pushNamed(context,  TermsAndConditionsView.routeName);
            },
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'By creating an account, you agree to ',
                    style: TextStyles.textstyle14.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                  TextSpan(
                    text: 'our terms and conditions',
                    style:
                        TextStyles.textstyle14.copyWith(color: Color(0xFF407165)),
                  ),
                ],
              ),
            ),
          ),
        ),
        
      ],
    );
  }
}
