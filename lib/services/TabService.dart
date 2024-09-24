// ignore_for_file: file_names

import 'package:toby_flutter/services/api_service_wrapper.dart';

class TabService {
  final ApiServiceWrapper _apiWrapper = ApiServiceWrapper();

  // Fetch all tabs for a specific collection
  Future<Map<String, dynamic>> fetchTabs(int collectionId) async {
    final response = await _apiWrapper.post('/tabs', {
      'collection_id': collectionId,
    });
    return response;
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
