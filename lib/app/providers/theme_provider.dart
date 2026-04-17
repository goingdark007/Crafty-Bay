import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{

  ThemeMode _themeMode = ThemeMode.system;

  static const String _themeKey = 'theme';

  ThemeMode get themeMode => _themeMode;

  List<ThemeMode> get supportedThemes => ThemeMode.values;

  void changeTheme(ThemeMode newTheme){

    _themeMode = newTheme;
    _saveTheme();
    notifyListeners();

  }

  Future<void> _saveTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_themeKey, _themeMode.name);
  }

  Future<void> loadTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? theme = sharedPreferences.getString(_themeKey);
    if(theme != null) {
      _themeMode = ThemeMode.values.firstWhere((element) => element.name == theme);
      notifyListeners();
    }
  }


}