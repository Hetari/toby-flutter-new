import 'package:flutter/material.dart';

class CollectionSectionWidget extends StatelessWidget {
  final String sectionTitle;
  final List<Map<String, dynamic>> cardsData;

  const CollectionSectionWidget({
    super.key,
    required this.sectionTitle,
    required this.cardsData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            sectionTitle,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cardsData.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // عدد الأعمدة
            childAspectRatio: 3 / 2,
          ),
          itemBuilder: (context, index) {
            final card = cardsData[index];
            return GestureDetector(
              onTap: card['onTap'], // استدعاء دالة onTap هنا
              child: Card(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // محاذاة مركزية للعناصر
                  children: [
                    Icon(card['icon'], color: card['color']),
                    Text(card['title'], style: const TextStyle(fontSize: 18)),
                    Text(card['subtitle'],
                        style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
