import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceWrapper {
  // final String baseUrl = 'http://10.0.2.2:8000/api'; //when use flutter emulator
  final String baseUrl = 'http://127.0.0.1:8000/api'; // when use chrome web

  // Generic method for making POST requests
  static const Map<String, String> defaultHeaders = {
    'Content-Type':
        'application/json', // Specifies that you're sending JSON data
    'Accept':
        'application/json', // Specifies that you expect JSON data in response
    'User-Agent': 'Toby/1.0.0', // Identifies your app to the server
  };

  // New method for making GET requests
  Future<Map<String, dynamic>> get(
      String endpoint, Map<String, String> headers) async {
    final url = Uri.parse('$baseUrl$endpoint');

    try {
      final response = await http.get(
        url,
        headers: {...headers, ...defaultHeaders},
      );

      return _handleResponse(response);
    } catch (e) {
      return _handleException(e);
    }
  }

  // Generic method for making POST requests
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body,
      Map<String, String> headers) async {
    final url = Uri.parse('$baseUrl$endpoint');

    try {
      final response = await http.post(
        url,
        headers: {...headers, ...defaultHeaders},
        body: jsonEncode(body),
      );

      return _handleResponse(response);
    } catch (e) {
      return _handleException(e);
    }
  }

  // الدالة العامة لطلبات PUT
  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> body,
      Map<String, String> headers) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.put(
        url,
        headers: {...headers, ...defaultHeaders},
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      return _handleException(e);
    }
  }

  // الدالة العامة لطلبات DELETE
  Future<Map<String, dynamic>> delete(
      String endpoint, Map<String, String> headers) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.delete(
        url,
        headers: {...headers, ...defaultHeaders},
      );
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      return _handleResponse(response);
    } catch (e) {
      // print("hello $e");
      return _handleException(e);
    }
  }

  // Handle response parsing
  Map<String, dynamic> _handleResponse(http.Response response) {
    final decoded = jsonDecode(response.body);
    print(decoded);
    return decoded is Map<String, dynamic>
        ? decoded
        : {'error': 'Unexpected response format'};
  }

  // Handle exceptions like network errors
  Map<String, dynamic> _handleException(dynamic e) {
    return {'error': 'Request failed: $e'};
  }
}
