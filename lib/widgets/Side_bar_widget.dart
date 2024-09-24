// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:toby_flutter/widgets/SideBarMenuWidget.dart';

class SideBarWidget extends StatelessWidget {
  const SideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
            ),
            child: Text(
              'Acme Inc',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          SideBarMenuWidget(title: 'Starred Collections', icon: Icons.star),
          SideBarMenuWidget(title: 'My Collections', icon: Icons.list),
          SideBarMenuWidget(title: 'How to Use Toby', icon: Icons.info),
          SideBarMenuWidget(title: 'Personal', icon: Icons.person),
          SideBarMenuWidget(title: 'Travel', icon: Icons.travel_explore),
          SideBarMenuWidget(title: 'Recipes', icon: Icons.fastfood),
        ],
      ),
    );
  }
}
