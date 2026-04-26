import 'dart:convert';

import 'package:crafty_bay/features/shared/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController { // We can use it with like service locator (like a setup file)

  static const String _accessTokenKey = 'access_token';
  static const String _userDataKey = 'user_data';

  static String? _accessToken;
  static UserModel? _userModel;

  static String? get accessToken => _accessToken;
  static UserModel? get userModel => _userModel;


  static Future<void> saveUserData(String token, UserModel user) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(_accessTokenKey, token);
    await prefs.setString(_userDataKey, jsonEncode(user.toJson()));

    _accessToken = token;
    _userModel = user;

  }

  static Future<void> loadUserData () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString(_accessTokenKey);
    final userData = prefs.getString(_userDataKey);
    if (userData != null) _userModel = UserModel.fromJson(jsonDecode(userData));

  }

  static Future<bool> isLoggedIn () async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey) != null;

  }

  static Future<void> clearUserData () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_userDataKey);
    _accessToken = null;
    _userModel = null;
  }



}