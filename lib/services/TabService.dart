// ignore_for_file: file_names, unnecessary_type_check

import 'package:toby_flutter/providers/app_state.dart';
import 'package:toby_flutter/services/api_service_wrapper.dart';

class TabService {
  final ApiServiceWrapper _apiWrapper = ApiServiceWrapper();
  late final AppState _appState; // يجب أن يتم تعيين _appState في الكونستركتور

  TabService(AppState appState) {
    _appState = appState; // تعيين AppState في الكونستركتور
  }

  // Fetch all tabs for a specific collection
  Future<List<dynamic>> fetchTabs(int collectionId) async {
    print('Fetching tabs for collection ID: $collectionId');
    if (_appState.isLoggedIn) {
      final token = _appState.userToken;

      if (token == null || token.isEmpty) {
        throw Exception('User is not authenticated. Please log in.');
      }

      // Prepare the headers with the token
      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      };

      final response = await _apiWrapper.get('/tabs', headers);

      if (response.containsKey('error')) {
        // Handle error in response
        return [];
      }

      if (response is Map && response['data'] is List) {
        return response['data']; // Return data if it's a list
      }
    }
    return [];
  }

  // Fetch all tabs
  Future<List<dynamic>> fetchAllTabs() async {
    if (_appState.isLoggedIn) {
      final token = _appState.userToken;

      if (token == null || token.isEmpty) {
        throw Exception('User is not authenticated. Please log in.');
      }

      // Prepare the headers with the token
      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      };

      final response = await _apiWrapper.get('/tabs', headers);

      if (response.containsKey('error')) {
        // Handle error in response
        return [];
      }

      if (response is Map && response['data'] is List) {
        return response['data']; // Return data if it's a list
      }
    }
    return [];
  }

  // Create a new tab
  Future<Map<String, dynamic>> createTab(String title, int collectionId) async {
    if (_appState.isLoggedIn) {
      final token = _appState.userToken;

      if (token == null || token.isEmpty) {
        throw Exception('User is not authenticated. Please log in.');
      }

      // Prepare the headers with the token
      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      };

      final response = await _apiWrapper.post(
          '/tabs/create',
          {
            'title': title,
            'collection_id': collectionId,
          },
          headers);
      return response; // Consider handling response error here
    }
    return {};
  }

  // Delete a tab
  Future<Map<String, dynamic>> deleteTab(int id) async {
    if (_appState.isLoggedIn) {
      final token = _appState.userToken;

      if (token == null || token.isEmpty) {
        throw Exception('User is not authenticated. Please log in.');
      }

      // Prepare the headers with the token
      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      };
      final response = await _apiWrapper.post(
          '/tabs/delete',
          {
            'id': id,
          },
          headers);
      return response; // Consider handling response error here
    }
    return {};
  }
}
