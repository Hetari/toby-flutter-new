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

      if (response['data'] is List) {
        return response['data'];
      } else if (response['data'] is Map) {
        return response['data'].values.toList();
      }
    }
    return [];
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

  // Update an existing collection
  Future<void> updateCollection(
      int id, String title, String description) async {
    if (_appState.isLoggedIn) {
      final token = _appState.userToken;

      if (token == null || token.isEmpty) {
        throw Exception('User is not authenticated. Please log in.');
      }

      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'title': title,
        'description': description
      };

      await _apiWrapper.put(
        '/collections/$id',
        headers: headers,
      );
    }
  }

  // Delete a collection
  Future<void> deleteCollection(int id) async {
    if (_appState.isLoggedIn) {
      final token = _appState.userToken;

      if (token == null || token.isEmpty) {
        throw Exception('User is not authenticated. Please log in.');
      }

      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      };

      await _apiWrapper.delete(
        '/collections/$id',
        headers: headers,
      );
    }
  }
}
