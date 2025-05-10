import 'package:flutter/material.dart';

class TipsAndAdviceViewBody extends StatefulWidget {
  const TipsAndAdviceViewBody({super.key});

  @override
  State<TipsAndAdviceViewBody> createState() => _TipsAndAdviceViewBodyState();
}

class _TipsAndAdviceViewBodyState extends State<TipsAndAdviceViewBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  final List<TipItem> _tipItems = [
    TipItem(
      title: 'Improve Your Credit Score',
      description:
          'A good credit score is crucial for loan approval. Here\'s how to improve it:',
      tips: [
        'Pay bills on time',
        'Keep credit card balances low',
        'Don\'t close old credit accounts',
        'Limit new credit applications',
        'Check your credit report regularly',
      ],
      category: 'Credit Score',
      icon: Icons.credit_score,
      color: Colors.blue,
    ),
    TipItem(
      title: 'Manage Your Debt',
      description:
          'Effective debt management increases your loan approval chances:',
      tips: [
        'Calculate your debt-to-income ratio',
        'Pay off high-interest debts first',
        'Consider debt consolidation',
        'Create a debt repayment plan',
        'Avoid taking on new debt before applying',
      ],
      category: 'Debt Management',
      icon: Icons.account_balance_wallet,
      color: Colors.green,
    ),
    TipItem(
      title: 'Prepare Your Documents',
      description:
          'Having the right documents ready speeds up the loan process:',
      tips: [
        'Recent pay stubs or income proof',
        'Bank statements (3-6 months)',
        'Tax returns (2-3 years)',
        'Employment verification',
        'Valid government ID',
      ],
      category: 'Documentation',
      icon: Icons.description,
      color: Colors.orange,
    ),
    TipItem(
      title: 'Choose the Right Loan',
      description: 'Selecting the appropriate loan type is crucial:',
      tips: [
        'Compare different loan types',
        'Understand interest rates',
        'Check loan terms and conditions',
        'Calculate total repayment amount',
        'Consider your financial goals',
      ],
      category: 'Loan Selection',
      icon: Icons.account_balance,
      color: Colors.purple,
    ),
    TipItem(
      title: 'Build a Strong Application',
      description: 'Make your loan application stand out:',
      tips: [
        'Maintain stable employment',
        'Show consistent income',
        'Have a good savings history',
        'Explain any credit issues',
        'Provide collateral if possible',
      ],
      category: 'Application',
      icon: Icons.assignment_turned_in,
      color: Colors.teal,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Loan Tips & Advice',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Expert advice to improve your loan approval chances',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ..._buildTipSections(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTipSections() {
    return _tipItems.map((item) => _buildTipCard(item)).toList();
  }

  Widget _buildTipCard(TipItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: item.color.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: item.color.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  color: item.color,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: item.color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.category,
                        style: TextStyle(
                          fontSize: 14,
                          color: item.color.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                ...item.tips.map((tip) => _buildTipItem(tip, item.color)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String tip, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            color: color,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TipItem {
  final String title;
  final String description;
  final List<String> tips;
  final String category;
  final IconData icon;
  final Color color;

  const TipItem({
    required this.title,
    required this.description,
    required this.tips,
    required this.category,
    required this.icon,
    required this.color,
  });
}
