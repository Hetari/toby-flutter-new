// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toby_flutter/providers/app_state.dart';
import 'package:toby_flutter/services/CollectionService.dart';
import 'package:toby_flutter/widgets/CollectionSectionWidget.dart';
import 'package:toby_flutter/widgets/HeaderWidget.dart';

class MainContentWidget extends StatefulWidget {
  const MainContentWidget({super.key});

  @override
  _MainContentWidgetState createState() => _MainContentWidgetState();
}

class _MainContentWidgetState extends State<MainContentWidget> {
  late CollectionService apiService;

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    apiService = CollectionService(appState);
  }

  Future<List<dynamic>> fetchCollections() async {
    try {
      // تحقق من أن المستخدم مسجل الدخول
      return await apiService.fetchCollections();
    } catch (e) {
      print("Error fetching collections: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderWidget(title: 'My Collections'),
          FutureBuilder<List<dynamic>>(
            future: fetchCollections(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                List<dynamic> collections = snapshot.data!;
                return CollectionSectionWidget(
                  sectionTitle: 'API Collections',
                  cardsData: collections.map((collection) {
                    return {
                      'title': collection['title'] ?? 'Untitled',
                      'subtitle': collection['subtitle'] ?? 'No description',
                      'icon': Icons.folder,
                      'color': Colors.blue,
                    };
                  }).toList(),
                );
              } else {
                return const Center(child: Text('No collections found'));
              }
            },
          ),
        ],
      ),
    );
  }
}
