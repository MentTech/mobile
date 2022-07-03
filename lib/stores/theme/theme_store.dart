import 'package:flutter/material.dart';
import 'package:mobile/constants/assets.dart';
import 'package:mobile/constants/colors.dart';
import 'package:mobile/data/repository.dart';
import 'package:mobx/mobx.dart';

part 'theme_store.g.dart';

class ThemeStore = _ThemeStore with _$ThemeStore;

abstract class _ThemeStore with Store {
  // ignore: non_constant_identifier_names
  final String TAG = "_ThemeStore";

  // repository instance
  final Repository _repository;

  // store variables:-----------------------------------------------------------
  @observable
  bool _darkMode = false;

  // getters:-------------------------------------------------------------------
  @computed
  bool get darkMode => _darkMode;

  @computed
  String get modeName => _darkMode ? "Dark mode" : "Light mode";

  @computed
  String get appIcon => _darkMode ? Assets.appLogoDark : Assets.appLogoLight;

  @computed
  Color get themeColorfulColor =>
      _darkMode ? AppColors.darkTextTheme : AppColors.lightTextTheme;

  @computed
  Color get themeColor => _darkMode ? dark : light;

  @computed
  Color get themeThemeColor => _darkMode ? darkTheme : lightTheme;

  @computed
  List<Color> get lineToLineGradientColors =>
      darkMode ? _lineToLineGradientColorsDark : _lineToLineGradientColorsLight;

  @computed
  List<Color> get _lineToLineGradientColorsDark => [
        Color.alphaBlend(
          themeThemeColor.withAlpha(150),
          themeColorfulColor,
        ),
        themeColorfulColor,
        Color.alphaBlend(
          themeThemeColor.withAlpha(150),
          themeColorfulColor,
        ),
      ];

  @computed
  List<Color> get _lineToLineGradientColorsLight => [
        Color.alphaBlend(
          themeThemeColor,
          themeColorfulColor,
        ),
        themeColorfulColor,
        Color.alphaBlend(
          themeThemeColor,
          themeColorfulColor,
        ),
      ];

  // constructor:---------------------------------------------------------------
  _ThemeStore(Repository repository) : _repository = repository {
    init();
  }

  // actions:-------------------------------------------------------------------
  @action
  Future changeBrightnessToDark(bool value) async {
    _darkMode = value;
    await _repository.changeBrightnessToDark(value);
  }

  // general methods:-----------------------------------------------------------

  List<double> get linearGradientStops => const [0, 0.35, 0.7];

  Color get textNotChoosed => Colors.grey.shade700;

  Color get darkTheme => Colors.black54;
  Color get lightTheme => Colors.white60;

  Color get dark => Colors.black87;
  Color get light => Colors.white70;

  Color get darkColorful => AppColors.darkTextTheme;
  Color get lightColorful => AppColors.lightTextTheme;

  Future init() async {
    _darkMode = _repository.isDarkMode;
  }

  bool isPlatformDark(BuildContext context) =>
      MediaQuery.platformBrightnessOf(context) == Brightness.dark;

  // dispose:-------------------------------------------------------------------
  @override
  // ignore: override_on_non_overriding_member
  dispose() {}
}
