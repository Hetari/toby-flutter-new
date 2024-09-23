import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceWrapper {
  final String baseUrl = 'http://127.0.0.1:8000/api';
  // Generic method for making POST requests
  Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endpoint');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      // Check for valid response (status code 200)
      if (response.statusCode == 200) {
        return _handleResponse(response);
      } else {
        return _handleError(response);
      }
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

  // Handle error responses
  Map<String, dynamic> _handleError(http.Response response) {
    final error = jsonDecode(response.body);
    return {
      'error': error['message'] ??
          'Request failed with status: ${response.statusCode}',
    };
  }

  // Handle exceptions like network errors
  Map<String, dynamic> _handleException(dynamic e) {
    return {'error': 'Request failed: $e'};
  }
}
