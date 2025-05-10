import 'package:flutter/material.dart';
import 'faq_item_model.dart';

class FaqData {
  static List<FaqItem> get faqItems => [
        FaqItem(
          question: 'How does the loan prediction system work?',
          answer:
              'Our AI-powered system analyzes various factors including your credit score, income, employment history, and loan amount to predict the likelihood of loan approval. The system uses machine learning algorithms trained on historical loan data to provide accurate predictions.',
          category: 'System Information',
          icon: Icons.psychology,
        ),
        FaqItem(
          question: 'What factors affect loan approval?',
          answer: 'Several key factors influence loan approval:\n\n'
              '• Credit Score: A higher score increases approval chances\n'
              '• Income: Stable and sufficient income is crucial\n'
              '• Employment History: Longer employment history is preferred\n'
              '• Debt-to-Income Ratio: Lower ratio is better\n'
              '• Loan Amount: Smaller amounts have higher approval rates\n'
              '• Loan Purpose: Some purposes are more favorable than others',
          category: 'Loan Basics',
          icon: Icons.assessment,
        ),
        FaqItem(
          question: 'How accurate are the predictions?',
          answer:
              'Our system achieves an accuracy rate of over 85% based on historical data. However, please note that predictions are estimates and actual loan approval depends on the lender\'s specific criteria and current market conditions.',
          category: 'System Information',
          icon: Icons.analytics,
        ),
        FaqItem(
          question: 'What types of loans can I check?',
          answer: 'Our system currently supports predictions for:\n\n'
              '• Personal Loans\n'
              '• Home Loans\n'
              '• Auto Loans\n'
              '• Business Loans\n'
              '• Education Loans',
          category: 'Loan Types',
          icon: Icons.account_balance,
        ),
        FaqItem(
          question: 'Is my personal information secure?',
          answer:
              'Yes, we take data security very seriously. All information you provide is encrypted and stored securely. We comply with international data protection standards and never share your personal information with third parties without your consent.',
          category: 'Security & Privacy',
          icon: Icons.security,
        ),
        FaqItem(
          question: 'How long does the prediction process take?',
          answer:
              'The prediction process is instant! Once you provide the required information, our AI system processes it within seconds and provides you with a detailed prediction report.',
          category: 'System Information',
          icon: Icons.timer,
        ),
        FaqItem(
          question: 'What if I disagree with the prediction?',
          answer:
              'While our predictions are based on comprehensive data analysis, they are estimates. If you believe your situation is unique or have additional information that might affect the outcome, we recommend consulting with a financial advisor or directly with potential lenders.',
          category: 'System Information',
          icon: Icons.help_outline,
        ),
      ];
} 