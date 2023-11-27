import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserManager extends ChangeNotifier {
  static const String _keyUserId = 'user_id';
  static const String _keyUserName = 'user_name';

  String? _userId;
  String? get userId => _userId;

  String? _userName;
  String? get userName => _userName;

  Future<void> saveUser(String userId, String userName) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyUserId, userId);
    prefs.setString(_keyUserName, userName);

    _userId = userId;
    _userName = userName;

    notifyListeners();
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString(_keyUserId);
    _userName = prefs.getString(_keyUserName);

    notifyListeners();
  }
}
