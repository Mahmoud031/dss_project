import 'package:flutter/material.dart';
import 'faq_item_model.dart';
import 'faq_item_widget.dart';

class FaqCategorySection extends StatelessWidget {
  final String category;
  final List<FaqItem> items;
  final IconData icon;

  const FaqCategorySection({
    super.key,
    required this.category,
    required this.items,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                category,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        ...items.map((item) => FaqItemWidget(item: item)),
        const Divider(height: 32),
      ],
    );
  }
} 