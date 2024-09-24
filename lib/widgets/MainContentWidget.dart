import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toby_flutter/providers/app_state.dart';
import 'package:toby_flutter/screens/add_collection.dart';
import 'package:toby_flutter/services/CollectionService.dart';
import 'package:toby_flutter/widgets/CollectionSectionWidget.dart';
import 'package:toby_flutter/widgets/FooterWidget.dart';
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
      return await apiService.fetchCollections();
    } catch (e) {
      print("Error fetching collections: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen height with MediaQuery
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: SizedBox(
        // Fix the height to the full screen
        height: screenHeight,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          'subtitle':
                              collection['description'] ?? 'No description',
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
              FooterWidget(
                onAddPressed: () {
                  // Navigate to Add Collection Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddCollectionScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
