// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SideBarMenuWidget extends StatelessWidget {
  final String title;
  final IconData icon;

  const SideBarMenuWidget({
    required this.title,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
    );
  }
}
