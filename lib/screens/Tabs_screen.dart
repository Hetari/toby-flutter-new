import 'package:flutter/material.dart';

class TabsPage extends StatelessWidget {
  final List<Map<String, dynamic>>? tabs; // Allow null

  const TabsPage({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs?.length ?? 0, // Set the number of tabs, default to 0 if null
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tabs'),
          bottom: tabs != null && tabs!.isNotEmpty
              ? TabBar(
                  isScrollable:
                      true, // Allows horizontal scrolling if tabs are too many
                  tabs: tabs!.map((tab) {
                    return Tab(
                        text: tab['title']); // Display the title for each tab
                  }).toList(),
                )
              : null, // No TabBar if there are no tabs
        ),
        body: tabs != null && tabs!.isNotEmpty
            ? TabBarView(
                children: tabs!.map((tab) {
                  return Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to another screen based on the URL
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebViewPage(url: tab['url']),
                          ),
                        );
                      },
                      child: Text('Go to ${tab['title']}'),
                    ),
                  );
                }).toList(),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'No tabs available',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Add functionality to add a new tab
                        // For example, you might navigate to a different screen
                        // to create a new tab
                      },
                      child: const Text('Add Tab'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

// Sample WebView page to display the URL
class WebViewPage extends StatelessWidget {
  final String url;

  const WebViewPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView for $url'),
      ),
      body: Center(
        child: Text('Loading content from $url'), // Replace with actual WebView
      ),
    );
  }
}
