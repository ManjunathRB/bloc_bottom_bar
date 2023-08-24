import 'package:bloc/bloc.dart';
import 'package:bloc_bottom_bar/presentation/themedata/theme_data.dart';
import 'package:flutter/material.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final BuildContext context;

  SettingsCubit(this.context) : super(SettingsInitial(lightTheme(context)));
  void toggleTheme() {
    if (state is DarkTheme) {
      emit(LightTheme(lightTheme(context)));
    } else {
      emit(DarkTheme(darkTheme(context)));
    }
  }
}
