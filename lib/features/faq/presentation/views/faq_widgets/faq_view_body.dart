import 'package:flutter/material.dart';
import 'faq_category_section.dart';
import 'faq_data.dart';
import 'faq_item_model.dart';

class FaqViewBody extends StatefulWidget {
  const FaqViewBody({super.key});

  @override
  State<FaqViewBody> createState() => _FaqViewBodyState();
}

class _FaqViewBodyState extends State<FaqViewBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

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
          'Frequently Asked Questions',
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
                    'Find answers to common questions about our loan prediction system',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ..._buildCategorySections(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCategorySections() {
    final Map<String, List<FaqItem>> categorizedItems = {};
    for (var item in FaqData.faqItems) {
      categorizedItems.putIfAbsent(item.category, () => []).add(item);
    }

    return categorizedItems.entries.map((entry) {
      return FaqCategorySection(
        category: entry.key,
        items: entry.value,
        icon: entry.value.first.icon,
      );
    }).toList();
  }
}
