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

      if (token == null || token.isEmpty) {
        throw Exception('User is not authenticated. Please log in.');
      }
      // Prepare the headers with the token
      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      };
      final response = await _apiWrapper.get('/collections', headers: headers);
      // print(response['success']);
      if (response.containsKey('error')) {
        // إذا كانت هناك خطأ في الاستجابة
        return []; // أو يمكنك إلقاء استثناء حسب حاجتك
      }

      if (response is Map && response['data'] is List) {
        return response['data']; // إرجاع البيانات إذا كانت قائمة
      }
    }
    return []; // إرجاع قائمة فارغة إذا لم يكن المستخدم مسجلاً للدخول
  }

  // Create a new collection
  Future<Map<String, dynamic>> createCollection(String title) async {
    final response = await _apiWrapper.post('/collections/', {
      'title': title,
    });
    return response;
  }

  // Delete a collection
  Future<Map<String, dynamic>> deleteCollection(int id) async {
    final response = await _apiWrapper.post('/collections/delete', {
      'id': id,
    });
    return response;
  }
}
