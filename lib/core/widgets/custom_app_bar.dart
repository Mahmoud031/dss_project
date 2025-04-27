import 'package:dss_project/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      color: Color(0xFF071A26),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                
              },
              icon: Icon(
                Icons.menu,
                color: Colors.white,
                size: MediaQuery.of(context).size.width * 0.09,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            Text(
              title,
              style: TextStyles.textstyle34.copyWith(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.08,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
