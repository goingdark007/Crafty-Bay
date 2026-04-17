import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../l10n/app_localizations.dart';

class LocalizationProvider extends ChangeNotifier{

  Locale _locale = Locale('en');

  static const String _localeKey = 'locale';

  Locale get locale => _locale;
  List<Locale> get supportedLocales => AppLocalizations.supportedLocales;

  void changeLocal(Locale newLocale){

    _locale = newLocale;
    _saveLocale();
    notifyListeners();

  }

  Future<void> _saveLocale() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_localeKey, _locale.languageCode);
  }

  Future<void> loadLocale() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? languageCode = sharedPreferences.getString(_localeKey);
    if(languageCode != null) {
      _locale = Locale(languageCode);
      notifyListeners();
    }

  }

}