import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // استيراد Provider
import 'package:toby_flutter/providers/app_state.dart';
import 'package:toby_flutter/services/TabService.dart';

class TabsPage extends StatelessWidget {
  final int collectionId;

  const TabsPage({super.key, required this.collectionId});

  Future<List<dynamic>> fetchTabs(BuildContext context) async {
    try {
      // جلب AppState من Provider
      final appState = Provider.of<AppState>(context, listen: false);
      // تمرير AppState إلى TabService
      return await TabService(appState).fetchTabs(collectionId);
    } catch (e) {
      print("Error fetching tabs: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabs'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchTabs(context), // تمرير السياق
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<dynamic> tabs = snapshot.data!;
            return ListView.builder(
              itemCount: tabs.length,
              itemBuilder: (context, index) {
                final tab = tabs[index];
                return ListTile(
                  title: Text(tab['title'] ?? 'Untitled'),
                  subtitle: Text(tab['description'] ?? 'No description'),
                );
              },
            );
          } else {
            return const Center(child: Text('No tabs found'));
          }
        },
      ),
    );
  }
}
