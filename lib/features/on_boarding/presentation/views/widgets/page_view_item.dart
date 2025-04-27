import 'package:dss_project/features/auth/presentation/views/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'get_started_button.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem(
      {super.key,
      required this.image,
      required this.title,
      required this.isVisible,
      required this.currentPage,
      required this.pageController});
  final String image;
  final String title;
  final bool isVisible;
  final int currentPage;
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset(image, fit: BoxFit.fill),
          SizedBox(
            height: 40,
          ),
          Visibility(
            visible: currentPage == 1 ? false : true,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF7D8F8B),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                icon: Icon(
                  Icons.arrow_forward_rounded,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Visibility(
            visible: currentPage == 1 ? true : false,
            child: GetStartedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(SignInView.routeName);
              },
              text: 'Get Started',
              icon: Icons.arrow_forward_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
