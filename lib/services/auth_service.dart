// ignore_for_file: use_build_context_synchronously

import 'package:toby_flutter/providers/app_state.dart';
import 'package:toby_flutter/services/api_service_wrapper.dart';
import 'package:provider/provider.dart'; // استيراد Provider
import 'package:flutter/material.dart'; // ضروري لـ BuildContext

class AuthService {
  final ApiServiceWrapper _apiWrapper = ApiServiceWrapper();

  // Method to handle user login
  Future<Map<String, dynamic>> login(
      BuildContext context, String email, String password) async {
    // print("hello login");

    // final headers = _getHeaders(); // استخدام الدالة للحصول على headers
    final response = await _apiWrapper.post('/login', {
      'email': email,
      'password': password,
    }, {});

    bool isLoggedIn = response['success'] ?? false;
    // إذا كانت الاستجابة ناجحة، قم بتخزين البيانات في AppState
    if (isLoggedIn) {
      // الوصول إلى AppState باستخدام Provider
      final appState = Provider.of<AppState>(context, listen: false);
      await appState.logIn(email, response['data']['access_token']);
    }

    return response;
  }

  Future<Map<String, dynamic>> register(
      BuildContext context, String name, String email, String password) async {
    final response = await _apiWrapper.post('/register', {
      'name': name,
      'email': email,
      'password': password,
    }, {});

    if (response['success']) {
      // الوصول إلى AppState باستخدام Provider
      final appState = Provider.of<AppState>(context, listen: false);
      await appState.logIn(email, response['data']['access_token']);
    }

    return response;
  }
}
