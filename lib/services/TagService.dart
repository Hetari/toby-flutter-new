import 'package:toby_flutter/providers/app_state.dart';
import 'package:toby_flutter/services/api_service_wrapper.dart';

class TagService {
  final ApiServiceWrapper _apiWrapper = ApiServiceWrapper();
  late final AppState _appState;

  // Helper function to get headers
  Map<String, String> _getHeaders() {
    final token = _appState.userToken;
    // Fetch all tags for a specific tab
    return {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
  }

  // Fetch all tags for a specific tab
  Future<Map<String, dynamic>> fetchTags(int tabId) async {
    final headers = _getHeaders(); // استخدام الدالة للحصول على headers
    final response = await _apiWrapper.get(
      '/tags',
      headers,
    );
    return response;
  }

  // Create a new tag
  Future<Map<String, dynamic>> createTag(String name, int tabId) async {
    final headers = _getHeaders(); // استخدام الدالة للحصول على headers
    final response = await _apiWrapper.post(
      '/tags/create',
      {
        'name': name,
        'tab_id': tabId,
      },
      headers,
    );
    return response;
  }

  // Delete a tag
  Future<Map<String, dynamic>> deleteTag(int id) async {
    final headers = _getHeaders(); // استخدام الدالة للحصول على headers
    final response = await _apiWrapper.post(
      '/tags/delete',
      {
        'id': id,
      },
      headers,
    );
    return response;
  }
}
