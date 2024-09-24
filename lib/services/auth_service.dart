import 'package:toby_flutter/providers/app_state.dart';
import 'package:toby_flutter/services/api_service_wrapper.dart';

class AuthService {
  final ApiServiceWrapper _apiWrapper = ApiServiceWrapper();

  // Method to handle user login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _apiWrapper.post('/login', {
      'email': email,
      'password': password,
    });

    // print(response['data']);
    if (response['success']) {
      AppState().logIn(email, response['data']['access_token']);
    }
    return response;
  }

  Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    final response = await _apiWrapper.post('/register', {
      'name': name,
      'email': email,
      'password': password,
    });

    return response;
  }
}
