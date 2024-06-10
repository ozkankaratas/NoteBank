import 'package:flutter/material.dart';
import 'package:notebank/theme/theme.dart';

class ThemeProvider with ChangeNotifier{
  // başlangıçta açık tema
  ThemeData _themeData = lightMode;

  // getter method her yerden erişim için
  ThemeData get themeData => _themeData;

  // koyu temada olup olmadığımızı görmek için getter method
  bool get isDarkMode => _themeData == darkMode;

  // setter method yeni temayı ayarlamak için
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(){
    if(_themeData == lightMode){
      themeData = darkMode;
    }
    else{
      themeData = lightMode;
    }
  }

}