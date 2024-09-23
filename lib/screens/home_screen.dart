import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toby_flutter/providers/app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<AppState>(
              builder: (context, appState, child) {
                return Text('Data: ${appState.data}');
              },
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<AppState>(context, listen: false)
                    .updateData('New data from Home');
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Go to Details'),
            ),
          ],
        ),
      ),
    );
  }
}
