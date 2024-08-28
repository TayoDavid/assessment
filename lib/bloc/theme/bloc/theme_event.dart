part of 'theme_bloc.dart';

enum AppThemeMode { light, dark }

sealed class ThemeEvent {
  Future<void> handle(ThemeBloc bloc, Emitter emit);
}

class ToggleTheme extends ThemeEvent {
  
  final AppThemeMode mode;

  ToggleTheme(this.mode);

  @override
  Future<void> handle(ThemeBloc bloc, Emitter emit) async {   
    final themeData = mode == AppThemeMode.light ? ThemeState.lightThemeData : ThemeState.darkThemeData; 
    emit(ThemeState(themeData));
  }
}


