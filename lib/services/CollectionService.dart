// ignore_for_file: unnecessary_type_check

import 'package:toby_flutter/providers/app_state.dart';
import 'package:toby_flutter/services/api_service_wrapper.dart';

class CollectionService {
  final ApiServiceWrapper _apiWrapper = ApiServiceWrapper();
  final AppState _appState;

  CollectionService(this._appState);

  // Fetch all collections for the logged-in user
  Future<List<dynamic>> fetchCollections() async {
    if (_appState.isLoggedIn) {
      final token = _appState.userToken;

      if (token == null || token.isEmpty) {
        throw Exception('User is not authenticated. Please log in.');
      }

      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      };

      final response = await _apiWrapper.get('/collections', headers: headers);
      if (response.containsKey('error')) {
        return [];
      }

      if (response is Map && response['data'] is List) {
        return response['data']; // إرجاع البيانات إذا كانت قائمة
      }
    }
    return []; // إرجاع قائمة فارغة إذا لم يكن المستخدم مسجلاً للدخول
  }

  // Create a new collection
  Future<Map<String, dynamic>> createCollection(
      String title, String description) async {
    if (_appState.isLoggedIn) {
      final token = _appState.userToken;

      if (token == null || token.isEmpty) {
        throw Exception('User is not authenticated. Please log in.');
      }

      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      };

      final response = await _apiWrapper.post(
        '/collections/',
        {'title': title, 'description': description},
        headers: headers,
      );

      return response;
    }
    return {};
  }

  // Delete a collection
  Future<Map<String, dynamic>> deleteCollection(int id) async {
    if (_appState.isLoggedIn) {
      final token = _appState.userToken;

      if (token == null || token.isEmpty) {
        throw Exception('User is not authenticated. Please log in.');
      }

      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      };
      final response = await _apiWrapper.post(
        '/collections/delete',
        {
          'id': id,
        },
        headers: headers,
      );

      return response;
    }
    return {};
  }
}
