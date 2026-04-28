import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String userId = 'userId';
  static const String userName = 'userName';
  static const String userEmail = 'userEmail';
  static const String isLoggedIn = 'isLoggedIn';
  static const String userPhone = 'userPhone';
  static const String Image = 'Image';
  static late SharedPreferences _prefs;
  static late FlutterSecureStorage secureStorage;
  static init() async {
    _prefs = await SharedPreferences.getInstance();
    secureStorage = FlutterSecureStorage();
  }

  static Future<void> saveLogin({
    required String userId,
    required String userName,
    required String userEmail,
    required bool isLoggedIn,
    required String userPhone,
    required String accessToken,
  }) async {
    await secureStorage.write(key: 'accessToken', value: accessToken);
    await _prefs.setString(LocalStorageService.userId, userId);
    await _prefs.setString(LocalStorageService.userName, userName);
    await _prefs.setString(LocalStorageService.userEmail, userEmail);
    await _prefs.setBool(LocalStorageService.isLoggedIn, isLoggedIn);
    await _prefs.setString(LocalStorageService.userPhone, userPhone);
  }

  static bool isUserLoggedIn() {
    return _prefs.getBool(LocalStorageService.isLoggedIn) ?? false;
  }

  static String? getName() {
    return _prefs.getString(LocalStorageService.userName);
  }

  static String? getUserId() {
    return _prefs.getString(LocalStorageService.userId);
  }

  static String? getEmail() {
    return _prefs.getString(LocalStorageService.userEmail);
  }

  static String? getPhone() {
    return _prefs.getString(LocalStorageService.userPhone);
  }

  static Future<void> clear() async {
    await _prefs.clear();
    await secureStorage.deleteAll();
  }

  static Future<void> saveName(String name) async {
    await _prefs.setString(LocalStorageService.userName, name);
  }

  static Future<void> saveEmail(String email) async {
    await _prefs.setString(LocalStorageService.userEmail, email);
  }

  static Future<void> savePhone(String phone) async {
    await _prefs.setString(LocalStorageService.userPhone, phone);
  }

  static Future<void> saveImage(String imageUrl) async {
    await _prefs.setString('imageUrl', imageUrl);
  }

  static Future<String?> getImage() async {
    return await _prefs.getString('imageUrl');
  }
}
