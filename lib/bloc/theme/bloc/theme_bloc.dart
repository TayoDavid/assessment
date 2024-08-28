import 'package:assessment/resources/theme/theme_data.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(ThemeState.lightThemeData)) {
    on<ThemeEvent>((event, emit) => event.handle(this, emit));
  }
}
