// ignore_for_file: file_names, unnecessary_type_check

import 'package:toby_flutter/providers/app_state.dart';
import 'package:toby_flutter/services/api_service_wrapper.dart';

class TabService {
  final ApiServiceWrapper _apiWrapper = ApiServiceWrapper();
  late final AppState _appState;

  TabService(AppState appState) {
    _appState = appState;
  }

  // Helper function to get headers
  Map<String, String> _getHeaders() {
    final token = _appState.userToken;

    if (token == null || token.isEmpty) {
      throw Exception('User is not authenticated. Please log in.');
    }

    return {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
  }

  // Fetch all tabs for a specific collection
  Future<List<dynamic>> fetchTabs(int collectionId) async {
    if (_appState.isLoggedIn) {
      final headers = _getHeaders();
      final response = await _apiWrapper.get('/tabs', headers);

      if (response.containsKey('error')) {
        return [];
      }

      if (response is Map && response['data'] is List) {
        return response['data'];
      }
    }
    return [];
  }

  // Fetch all tabs
  Future<List<dynamic>> fetchAllTabs() async {
    if (_appState.isLoggedIn) {
      final headers = _getHeaders();
      final response = await _apiWrapper.get('/tabs', headers);

      if (response.containsKey('error')) {
        return [];
      }

      if (response is Map && response['data'] is List) {
        return response['data'];
      }
    }
    return [];
  }

  // Create a new tab
  Future<Map<String, dynamic>> createTab(
      String title, String url, int collectionId) async {
    final headers = _getHeaders();
    final response = await _apiWrapper.post(
      '/tabs',
      {
        'title': title,
        'url': url,
        'collection_id': collectionId,
      },
      headers,
    );

    return response;
  }

  Future<Map<String, dynamic>> deleteTab(int id) async {
    final headers = _getHeaders();
    // print('this is the tabe deleted $id');
    final response = await _apiWrapper.delete(
      '/tabs/$id',
      headers,
    );
    return response;
  }
}
