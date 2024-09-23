import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toby_flutter/providers/app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void logOut(BuildContext context) {
    // Log out the user by clearing their session in AppState
    Provider.of<AppState>(context, listen: false).logOut();

    // Navigate back to login screen
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    // Access AppState using Provider
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logOut(context), // Logout button
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display user's email from AppState
            Text(
              'Welcome, ${appState.userEmail ?? 'Guest'}!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Add more user data display here if necessary
            Text(
              'User data: ${appState.data.isEmpty ? "No data" : appState.data}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        // body: Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Consumer<AppState>(
        //         builder: (context, appState, child) {
        //           return Text('Data: ${appState.data}');
        //         },
        //       ),
        //       ElevatedButton(
        //         onPressed: () {
        //           Provider.of<AppState>(context, listen: false)
        //               .updateData('New data from Home');
        //           Navigator.pushReplacementNamed(context, '/login');
        //         },
        //         child: const Text('Go to Details'),
        //       ),
        //     ],
        //   ),
      ),
    );
  }
}
