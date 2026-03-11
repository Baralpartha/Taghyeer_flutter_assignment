import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/error/app_exception.dart';
import '../models/user_model.dart';

class LocalStorageDataSource {
  final SharedPreferences prefs;
  LocalStorageDataSource(this.prefs);

  static const _userKey = 'cached_user';
  static const _themeKey = 'is_dark_theme';

  Future<void> saveUser(UserModel user) async {
    final ok = await prefs.setString(_userKey, jsonEncode(user.toJson()));
    if (!ok) throw CacheException('Failed to cache user.');
  }

  UserModel? getUser() {
    final raw = prefs.getString(_userKey);
    if (raw == null) return null;
    return UserModel.fromJson(jsonDecode(raw));
  }

  Future<void> clearUser() async {
    await prefs.remove(_userKey);
  }

  Future<bool> saveTheme(bool isDark) async {
    return prefs.setBool(_themeKey, isDark);
  }

  bool getTheme() {
    return prefs.getBool(_themeKey) ?? false;
  }
}