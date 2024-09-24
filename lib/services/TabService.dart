// ignore_for_file: file_names, unnecessary_type_check

import 'package:toby_flutter/providers/app_state.dart';
import 'package:toby_flutter/services/api_service_wrapper.dart';

class TabService {
  final ApiServiceWrapper _apiWrapper = ApiServiceWrapper();
  late final AppState _appState;

  // Fetch all tabs for a specific collection
  Future<List<dynamic>> fetchTabs(int collectionId) async {
    print(collectionId);
    if (_appState.isLoggedIn) {
      final token = _appState.userToken; // الحصول على token المستخدم

      if (token == null || token.isEmpty) {
        throw Exception('User is not authenticated. Please log in.');
      }
      print(collectionId);
      // Prepare the headers with the token
      final headers = {
        'Authorization': 'Bearer $token',
        'id': '$collectionId',
        'Accept': 'application/json'
      };

      final response = await _apiWrapper.get('/tabs', headers: headers);
      // print(response['success']);
      if (response.containsKey('error')) {
        // إذا كانت هناك خطأ في الاستجابة
        return []; // أو يمكنك إلقاء استثناء حسب حاجتك
      }
      if (response is Map && response['data'] is List) {
        return response['data']; // إرجاع البيانات إذا كانت قائمة
      }
    }
    return [];
  }

  // Fetch all tabs
  Future<List<dynamic>> fetchAllTabs() async {
    if (_appState.isLoggedIn) {
      final response = await _apiWrapper.get('/tabs');
      print(response['success']);
      if (response.containsKey('error')) {
        // إذا كانت هناك خطأ في الاستجابة
        return []; // أو يمكنك إلقاء استثناء حسب حاجتك
      }
      if (response is Map && response['data'] is List) {
        return response['data']; // إرجاع البيانات إذا كانت قائمة
      }
    }
    return [];
  }

  // Create a new tab
  Future<Map<String, dynamic>> createTab(String title, int collectionId) async {
    final response = await _apiWrapper.post('/tabs/create', {
      'title': title,
      'collection_id': collectionId,
    });
    return response;
  }

  // Delete a tab
  Future<Map<String, dynamic>> deleteTab(int id) async {
    final response = await _apiWrapper.post('/tabs/delete', {
      'id': id,
    });
    return response;
  }
}
