// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:toby_flutter/widgets/CardWidget.dart';

class CollectionSectionWidget extends StatelessWidget {
  final String sectionTitle;
  final List<Map<String, dynamic>> cardsData;

  const CollectionSectionWidget({
    required this.sectionTitle,
    required this.cardsData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sectionTitle,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: cardsData.map((data) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0), // لتفادي تداخل البطاقات
                  child: CardWidget(
                    title: data['title'] ?? 'Untitled',
                    subtitle: data['description'] ?? 'No description',
                    icon: data['icon'],
                    color: data['color'],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
