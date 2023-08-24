part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {
  final ThemeData themeData;

  const SettingsState(this.themeData);
}

class SettingsInitial extends SettingsState {
  const SettingsInitial(super.themeData);
}

class LightTheme extends SettingsState {
  const LightTheme(super.themeData);
}

class DarkTheme extends SettingsState {
  const DarkTheme(super.themeData);
}
