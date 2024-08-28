part of 'theme_bloc.dart';

class ThemeState {
  final ThemeData themeData;

  ThemeState(this.themeData);

  static ThemeData get lightThemeData => lightMode;

  static ThemeData get darkThemeData => darkMode;
}
