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
      final token = _appState.userToken; // الحصول على token المستخدم
      // print(token);

      if (token == null || token.isEmpty) {
        throw Exception('User is not authenticated. Please log in.');
      }

      // Prepare the headers with the token
      final headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await _apiWrapper.get('/collections', headers);
      // print(response['success']);
      if (response.containsKey('error')) {
        return [];
      }

      if (response is Map && response['data'] is List) {
        return response['data']; // إرجاع البيانات إذا كانت قائمة
      } else if (response is Map && response['data'] is Map) {
        return response['data'].values.toList(); // إرجاع قائمة الكولكشنز
      }
      // return response['data'];
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
      };

      final response = await _apiWrapper.post(
        '/collections/',
        {'title': title, 'description': description},
        headers,
      );

      return response;
    }
    return {};
  }

  // Delete a collection
  Future<Map<String, dynamic>> deleteCollection(int id) async {
    // print("the id is : $id");
    final token = _appState.userToken;
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await _apiWrapper.delete(
      '/collections/$id',
      headers,
    );
    // print(response['success']);
    return response;
  }
}
