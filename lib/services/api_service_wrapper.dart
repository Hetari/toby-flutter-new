import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:toby_flutter/providers/app_state.dart';

class ApiServiceWrapper {
  final String baseUrl = 'http://127.0.0.1:8000/api';

  final appState = Provider.of<AppState>;

  // Generic method for making POST requests
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
  };

  // New method for making GET requests
  Future<Map<String, dynamic>> get(String endpoint,
      {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl$endpoint');

    try {
      final response = await http.get(
        url,
        headers: headers ?? {'Content-Type': 'application/json'},
      );

      return _handleResponse(response);
    } catch (e) {
      return _handleException(e);
    }
  }

  // Generic method for making POST requests
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body,
      {Map<String, String> headers = defaultHeaders}) async {
    final url = Uri.parse('$baseUrl$endpoint');

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      return _handleResponse(response);
    } catch (e) {
      return _handleException(e);
    }
  }

  // Handle response parsing
  Map<String, dynamic> _handleResponse(http.Response response) {
    final decoded = jsonDecode(response.body);
    return decoded is Map<String, dynamic>
        ? decoded
        : {'error': 'Unexpected response format'};
  }

  // Handle exceptions like network errors
  Map<String, dynamic> _handleException(dynamic e) {
    return {'error': 'Request failed: $e'};
  }
}
