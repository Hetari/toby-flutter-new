import 'package:toby_flutter/services/api_service_wrapper.dart';

class AuthService {
  final ApiServiceWrapper _apiWrapper = ApiServiceWrapper();

  // Method to handle user login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _apiWrapper.post('/login', {
      'email': email,
      'password': password,
    });
    return response;
  }
}
