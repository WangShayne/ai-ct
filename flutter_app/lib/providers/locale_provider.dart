import 'package:flutter/cupertino.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('zh');
  
  Locale get locale => _locale;
  
  void setLocale(Locale locale) {
    if (locale.languageCode != 'zh' && locale.languageCode != 'en') {
      return;
    }
    _locale = locale;
    notifyListeners();
  }
  
  void toggleLocale() {
    _locale = _locale.languageCode == 'zh' 
        ? const Locale('en') 
        : const Locale('zh');
    notifyListeners();
  }
}
