import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  String _themeMode = 'streets-v11';
  String get getTheme => _themeMode;

  void setDark() {
    _themeMode = 'dark-v10';
    notifyListeners();
  }

  void setLight() {
    _themeMode = 'streets-v11';
    notifyListeners();
  }

  void setSatellite() {
    _themeMode = 'satellite-streets-v11';
    notifyListeners();
  }

  void setNavigation() {
    _themeMode = 'navigation-day-v1';
    notifyListeners();
  }
}
