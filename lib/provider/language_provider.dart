import 'package:flutter/material.dart';

import '../pref/sharedprefrenace_language.dart';

class LanguageProvider extends ChangeNotifier {
  String language = SharedPrefController().language;

  void changeLanguage(String newLanguage) {
    // language = language == "en" ? "ar" : "en";
    language = newLanguage;
    SharedPrefController().changeLanguage(language: language);
    notifyListeners();
  }
}
