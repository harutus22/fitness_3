import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class LocaleProvider with ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    // if(!L10n.all.contains(locale)) return;
    // _locale = locale;
    // notifyListeners();
  }
}
