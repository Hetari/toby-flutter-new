import 'package:flutter/foundation.dart';

class AppState with ChangeNotifier {
  String _data = "";
  String? _userEmail; // Nullable email to track login status

  String get data => _data;
  String? get userEmail => _userEmail; // Getter for user email

  // Check if the user is logged in
  bool get isLoggedIn => _userEmail != null;

  void updateData(String newData) {
    _data = newData;
    notifyListeners();
  }

  // Log in the user by storing their email
  void logIn(String email) {
    _userEmail = email;
    notifyListeners();
  }

  // Log out the user and clear the email
  void logOut() {
    _userEmail = null;
    notifyListeners();
  }
}
