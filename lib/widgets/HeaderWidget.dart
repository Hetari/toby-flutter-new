import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions; // زر التحديث أو أي أدوات إضافية

  const HeaderWidget({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: actions, // يتم تمرير الأدوات الإضافية مثل زر التحديث هنا
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
