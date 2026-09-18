import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static final SharedPrefService _instance = SharedPrefService._internal();
  factory SharedPrefService() => _instance;
  SharedPrefService._internal();

  static SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

/// This method help to save token in app
  Future<void> saveToken(String token) async {
    await _prefs?.setString('token', token);
  }
  String? getToken() => _prefs?.getString('token');

/// Save userdata
  Future<void> saveUser({
    required String name,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("name", name);
    await prefs.setString("email", email);

    debugPrint("Saved Name: $name");
    debugPrint("Saved Email: $email");
  }

  Future<Map<String, String?>> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      "name": prefs.getString("name"),
      "email": prefs.getString("email"),
    };
  }
  static Future<void> setUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("userId", userId);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("userId");
  }
/// Profile image
  static const String _profileImageKey = "profile_image_path";

  Future<void> saveProfileImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileImageKey, path);
  }
  Future<String?> getProfileImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_profileImageKey);
  }

  /// Remove the saved profile image path.
  Future<void> removeProfileImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_profileImageKey);
  }

/// For Logout
  Future<void> logout() async {
    await _prefs?.remove("token");
    await _prefs?.remove("name");
    await _prefs?.remove("email");
  }
  /// full reset
  Future<void> clearAllData() async {
    await _prefs?.clear();
  }

  Future<void> clearAll() async => await _prefs?.clear();

  static Future<void> clear() async {
    await _prefs?.clear();
  }
}
