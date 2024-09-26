import 'package:flutter/material.dart';

class CollectionSectionWidget extends StatelessWidget {
  final List<Map<String, dynamic>> cardsData;
  final Function(int id, String title, String description)
      onUpdate; // دالة التحديث مع المعلمات المطلوبة
  final Function(int id) onDelete; // دالة الحذف

  const CollectionSectionWidget({
    super.key,
    required this.cardsData,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            return Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(card['icon'], color: card['color']),
                  Text(card['title'], style: const TextStyle(fontSize: 18)),
                  Text(card['subtitle'], style: const TextStyle(fontSize: 14)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          onUpdate(
                            card['id'],
                            card['title'],
                            card['subtitle'], // تمرير العنوان والوصف مع المعرف
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _confirmDelete(context, card['id']),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // تأكيد الحذف
  void _confirmDelete(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('تأكيد الحذف'),
          content: const Text('هل أنت متأكد من أنك تريد حذف هذه المجموعة؟'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // إغلاق نافذة التأكيد
              },
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                onDelete(id); // استدعاء دالة الحذف
                Navigator.of(context).pop(); // إغلاق نافذة التأكيد
              },
              child: const Text('حذف'),
            ),
          ],
        );
      },
    );
  }
}
