// ignore_for_file: unused_import

import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState with ChangeNotifier {
  String _data = "";
  String? _userEmail;
  String? _userToken;

  final box = GetStorage(); // إنشاء instance من GetStorage
  String? get data => _data;
  String? get userEmail => _userEmail;
  String? get userToken => _userToken;

  bool get isLoggedIn => _userEmail != null && _userToken != null;

  // تحميل حالة المستخدم عند بدء التطبيق
  void loadUser() {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // _userEmail = prefs.getString('userEmail');
    // _userToken = prefs.getString('userToken');
    // notifyListeners();

    _userEmail = box.read('userEmail');
    _userToken = box.read('userToken');
    notifyListeners(); // إشعار واجهة المستخدم للتحديث
  }

  String getToken() {
    return box.read('userToken');
  }

  // تحديث البيانات
  void updateData(String newData) {
    _data = newData;
    notifyListeners();
  }

  // تسجيل الدخول وحفظ البيانات في SharedPreferences
  Future<void> logIn(String email, String token) async {
    _userEmail = email;
    _userToken = token;
    box.write('userEmail', email);
    box.write('userToken', token);
    notifyListeners();
  }

  // تسجيل خروج وحذف البيانات من get_storage
  Future<void> logOut() async {
    _userEmail = null;
    _userToken = null;
    box.remove('userEmail');
    box.remove('userToken');
    notifyListeners();
  }
}
