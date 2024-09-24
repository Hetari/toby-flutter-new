import 'package:toby_flutter/providers/app_state.dart';
import 'package:toby_flutter/services/api_service_wrapper.dart';

class TagService {
  final ApiServiceWrapper _apiWrapper = ApiServiceWrapper();
  late final AppState _appState;

  // Fetch all tags for a specific tab
  Future<Map<String, dynamic>> fetchTags(int tabId) async {
    final token = _appState.userToken; // الحصول على token المستخدم

    if (token == null || token.isEmpty) {
      throw Exception('User is not authenticated. Please log in.');
    }
    // Prepare the headers with the token
    final headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };
    final response = await _apiWrapper.get(
      '/tags',
      headers: headers,
    );
    return response;
  }

  // Create a new tag
  Future<Map<String, dynamic>> createTag(String name, int tabId) async {
    final response = await _apiWrapper.post('/tags/create', {
      'name': name,
      'tab_id': tabId,
    });
    return response;
  }

  // Delete a tag
  Future<Map<String, dynamic>> deleteTag(int id) async {
    final response = await _apiWrapper.post('/tags/delete', {
      'id': id,
    });
    return response;
  }
}
