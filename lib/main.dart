import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toby_flutter/providers/app_state.dart';
import 'package:toby_flutter/screens/home_screen.dart';
import 'package:toby_flutter/screens/login_screen.dart';
import 'package:toby_flutter/screens/register_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Consumer<AppState>(
        builder: (context, appState, child) {
          // Check if the user is logged in
          if (appState.isLoggedIn) {
            return const HomeScreen(); // User is logged in
          } else {
            return LoginScreen(); // Redirect to login screen
          }
        },
      ),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}
