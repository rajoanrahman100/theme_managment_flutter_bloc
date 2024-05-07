import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_managment_flutter_bloc/cubit/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  static final ThemeData lightTheme = ThemeData.light();
  static final ThemeData darkTheme = ThemeData.dark();

  ThemeCubit() : super(ThemeState(lightTheme));

  void toggleTheme(bool isDark) {
    final themeData = isDark ? darkTheme : lightTheme;
    emit(ThemeState(themeData));
    _saveTheme(isDark);
  }

  void _saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark);
  }

  Future<bool> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDark') ?? false;
  }

  Future<void> setInitialTheme() async {
    final isDark = await loadTheme();
    final themeData = isDark ? darkTheme : lightTheme;
    emit(ThemeState(themeData));
  }
}
