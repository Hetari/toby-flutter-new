// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toby_flutter/providers/app_state.dart';
import 'package:toby_flutter/screens/Tabs_screen.dart';
import 'package:toby_flutter/screens/add_collection.dart';
import 'package:toby_flutter/services/CollectionService.dart';
import 'package:toby_flutter/widgets/CollectionSectionWidget.dart';
import 'package:toby_flutter/widgets/FooterWidget.dart';
import 'package:toby_flutter/widgets/HeaderWidget.dart';

class MainContentWidget extends StatefulWidget {
  const MainContentWidget({Key? key})
      : super(key: key); // تحديث المفتاح ليكون nullable

  @override
  _MainContentWidgetState createState() => _MainContentWidgetState();
}

class _MainContentWidgetState extends State<MainContentWidget> {
  late final CollectionService apiService; // وضع final هنا
  late Future<List<dynamic>> collectionsFuture;

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    apiService = CollectionService(appState);
    collectionsFuture = fetchCollections(); // استدعاء دالة fetchCollections
  }

  Future<List<dynamic>> fetchCollections() async {
    try {
      return await apiService.fetchCollections();
    } catch (e) {
      debugPrint(
          "Error fetching collections: $e"); // استخدام debugPrint بدلاً من print
      return [];
    }
  }

  void _refreshCollections() {
    setState(() {
      collectionsFuture =
          fetchCollections(); // تحديث المستقبل لجلب البيانات الجديدة
    });
  }

  // حذف مجموعة
  void _deleteCollection(int id) async {
    try {
      await apiService.deleteCollection(id);
      _refreshCollections(); // تحديث البيانات بعد الحذف
    } catch (e) {
      debugPrint("Error deleting collection: $e"); // استخدام debugPrint
    }
  }

  // تحديث مجموعة
  void _updateCollection(int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TabsPage(collectionId: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

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
      body: SafeArea(
        child: SizedBox(
          height: screenHeight,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<List<dynamic>>(
                  future: collectionsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      List<dynamic> collections = snapshot.data!;
                      return CollectionSectionWidget(
                        cardsData: collections.map((collection) {
                          List<dynamic> tags = collection['tags'] ?? [];
                          return {
                            'id': collection['id'],
                            'title': collection['title'] ?? 'Untitled',
                            'subtitle':
                                collection['description'] ?? 'No description',
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
                        onDelete: _deleteCollection,
                        onUpdate: _updateCollection,
                      );
                    } else {
                      return const Center(child: Text('No collections found'));
                    }
                  },
                ),
                FooterWidget(
                  onAddPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCollectionScreen(),
                      ),
                    );
                    if (result != null) {
                      // تحقق مما إذا كانت النتيجة غير فارغة
                      _refreshCollections(); // تحديث الصفحة إذا تم إنشاء مجموعة جديدة
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
