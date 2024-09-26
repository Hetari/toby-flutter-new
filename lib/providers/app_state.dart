import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toby_flutter/services/TabService.dart';

class AppState with ChangeNotifier {
  // متغيرات خاصة بحالة التطبيق
  String _data = "";
  String? _userEmail;
  String? _userToken;
  List<dynamic> tabs = []; // قائمة التبويبات

  // إنشاء instance من GetStorage
  final box = GetStorage();

  // Getter للوصول إلى القيم المخزنة
  String? get data => _data;
  String? get userEmail => _userEmail;
  String? get userToken => _userToken;

  // التحقق من حالة تسجيل الدخول
  bool get isLoggedIn => _userEmail != null && _userToken != null;

  // تحميل حالة المستخدم عند بدء التطبيق
  void loadUser() {
    _userEmail = box.read('userEmail');
    _userToken = box.read('userToken');
    notifyListeners(); // إشعار واجهة المستخدم بالتحديث
  }

  // الحصول على التوكن الحالي
  String? getToken() {
    return _userToken; // يمكن أيضاً استخدام box.read('userToken')
  }

  // تحديث البيانات
  void updateData(String newData) {
    _data = newData;
    notifyListeners();
  }

  // تسجيل الدخول وتخزين البيانات في GetStorage
  Future<void> logIn(String email, String token) async {
    _userEmail = email;
    _userToken = token;
    box.write('userEmail', email);
    box.write('userToken', token);
    notifyListeners();
  }

  // تسجيل الخروج وحذف البيانات من GetStorage
  Future<void> logOut() async {
    _userEmail = null;
    _userToken = null;
    box.remove('userEmail');
    box.remove('userToken');
    notifyListeners();
  }

  // دوال لإدارة التبويبات

  // تحديث قائمة التبويبات محلياً
  void updateTabs(List<dynamic> newTabs) {
    tabs = newTabs;
    notifyListeners(); // إشعار المستمعين بالتحديث
  }

  // حذف تبويب محلياً
  void removeTabLocally(int tabId) {
    tabs.removeWhere((tab) => tab['id'] == tabId);
    notifyListeners(); // إشعار المستمعين بالتحديث
  }

  // حذف تبويب من قاعدة البيانات عبر API
  Future<bool> deleteTabFromApi(int tabId, TabService apiService) async {
    final result = await apiService.deleteTab(tabId);

    if (result['success'] == true) {
      removeTabLocally(tabId); // حذف التبويب محلياً
      return true;
    } else {
      return false;
    }
  }
}
