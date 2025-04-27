import 'package:flutter/material.dart';

class TermsAndConditionsViewBody extends StatelessWidget {
  const TermsAndConditionsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('1. Use of Information'),
            const SizedBox(height: 10),
            Text(
              'We may use the information we collect from you in the following ways:\n'
              '• To personalize your experience\n'
              '• To improve our website\n'
              '• To process transactions\n'
              '• To send periodic emails\n',
            ),
            const SizedBox(height: 10),
            Text('2. Data Privacy and Security'),
            const SizedBox(height: 10),
            Text(
              'We take data privacy and security seriously. We implement a variety of security measures to maintain the safety of your personal information. However, no method of transmission over the internet or method of electronic storage is 100% secure. Therefore, we cannot guarantee its absolute security.\n',
            ),
            const SizedBox(height: 10),
            Text('3. Permitted Use'),
            const SizedBox(height: 10),
            Text(
              'You may not use our website for any illegal or unauthorized purpose. You agree to comply with all applicable laws and regulations in connection with your use of our website.\n',
            ),
            const SizedBox(height: 10),
            Text('4. Loan Application Disclaimer'),
            const SizedBox(height: 10),
            Text(
              'The information provided on this Application is for informational purposes only and does not constitute a loan application or an offer to lend. All loan applications are subject to approval based on our underwriting criteria.\n',
            ),
            const SizedBox(height: 10),
            Text('5. Changes to Terms and Privacy Policy'),
            const SizedBox(height: 10),
            Text(
              'We may update our terms and privacy policy from time to time. We will notify you of any changes by posting the new terms and privacy policy on our website. You are advised to review this page periodically for any changes.\n',
            ),
          ],
        ),
      ),
    );
  }
}
