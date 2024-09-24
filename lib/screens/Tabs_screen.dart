import 'package:flutter/material.dart';
import 'package:toby_flutter/services/TabService.dart';

class TabsPage extends StatelessWidget {
  final int collectionId;

  const TabsPage({super.key, required this.collectionId});
  Future<List<dynamic>> fetchTabs() async {
    try {
      // طلب التابس المرتبطة بالكولكشن بناءً على collectionId
      return await TabService().fetchTabs(collectionId);
    } catch (e) {
      print("Error fetching tabs: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    // استخدم TabService لجلب التابس المرتبطة بالكولكشن

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabs'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchTabs(),
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
                  title: Text(tab['name']),
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
