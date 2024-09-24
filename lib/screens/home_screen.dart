// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toby_flutter/providers/app_state.dart';
import 'package:toby_flutter/widgets/MainContentWidget.dart';
import 'package:toby_flutter/widgets/Side_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void logOut(BuildContext context) {
    Provider.of<AppState>(context, listen: false).logOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    // Access AppState using Provider
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home - Collections"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logOut(context),
          ),
        ],
      ),
      drawer: const SideBarWidget(),
      body: SafeArea(
        child: ChangeNotifierProvider.value(
          value: appState,
          child: const MainContentWidget(), // المحتوى الرئيسي
        ),
      ),
    );
  }
}
