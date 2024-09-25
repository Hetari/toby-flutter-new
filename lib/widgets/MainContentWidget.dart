// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toby_flutter/providers/app_state.dart';
import 'package:toby_flutter/screens/Tabs_screen.dart';
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
  late Future<List<dynamic>> collectionsFuture;

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    apiService = CollectionService(appState);
    collectionsFuture = fetchCollections();
  }

  Future<List<dynamic>> fetchCollections() async {
    try {
      return await apiService.fetchCollections();
    } catch (e) {
      print("Error fetching collections: $e");
      return [];
    }
  }

  void _refreshCollections() {
    setState(() {
      collectionsFuture = fetchCollections();
    });
  }

  // دالة الحذف
  void _deleteCollection(int id) async {
    try {
      await apiService.deleteCollection(id); // حذف المجموعة
      _refreshCollections(); // تحديث القائمة بعد الحذف
    } catch (e) {
      print("Error deleting collection: $e");
    }
  }

  // دالة التحديث
  void _updateCollection(int id) {
    // نقل البيانات إلى نموذج التحديث
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TabsPage(collectionId: id), // الانتقال إلى صفحة التحديث
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderWidget(
        title: 'My Collections',
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshCollections,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<List<dynamic>>(
              future: collectionsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error: ${snapshot.error}'),
                        ElevatedButton(
                          onPressed: _refreshCollections,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  List<dynamic> collections = snapshot.data!;
                  return CollectionSectionWidget(
                    sectionTitle: 'API Collections',
                    cardsData: collections.map((collection) {
                      List<dynamic> tags = collection['tags'] ?? [];
                      return {
                        'id': collection['id'],
                        'title': collection['title'] ?? 'Untitled',
                        'subtitle': collection['subtitle'] ?? 'No description',
                        'tags': tags,
                        'onTap': () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TabsPage(collectionId: collection['id']),
                            ),
                          );
                        },
                        'icon': Icons.folder,
                        'color': Colors.blue,
                      };
                    }).toList(),
                    onDelete: _deleteCollection, // تمرير دالة الحذف
                    onUpdate: _updateCollection, // تمرير دالة التحديث
                  );
                } else {
                  return const Center(child: Text('No collections found'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
