import 'package:flutter/material.dart';
import 'package:mobile/constants/assets.dart';
import 'package:mobile/constants/colors.dart';
import 'package:mobile/data/repository.dart';
import 'package:mobile/stores/message/message_store.dart';
import 'package:mobx/mobx.dart';

part 'theme_store.g.dart';

class ThemeStore = _ThemeStore with _$ThemeStore;

abstract class _ThemeStore with Store {
  // ignore: non_constant_identifier_names
  final String TAG = "_ThemeStore";

  // repository instance
  final Repository _repository;

  // store for handling errors
  final MessageStore messageStore = MessageStore();

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
  double get opacityTheme => _darkMode ? 0.65 : 0.75;

  @computed
  Color get themeColorfulColor =>
      _darkMode ? AppColors.darkTextTheme : AppColors.lightTextTheme;

  @computed
  Color get reverseThemeColorfulColor =>
      _darkMode ? AppColors.lightTextTheme : AppColors.darkTextTheme;

  @computed
  Color get themeColor => _darkMode ? dark : light;

  @computed
  Color get themeThemeColor => _darkMode ? darkTheme : lightTheme;

  @computed
  Color get reverseThemeColor => _darkMode ? light : dark;

  @computed
  List<Color> get linearGradientColors => [
        Color.alphaBlend(
          themeThemeColor,
          themeColorfulColor,
        ),
        Color.alphaBlend(
          themeThemeColor
              .withRed((themeColor.red * 0.7).round())
              .withGreen((themeColor.green * 0.7).round())
              .withBlue((themeColor.blue * 0.7).round()),
          themeColorfulColor,
        ),
        Color.alphaBlend(
          themeThemeColor
              .withRed((themeColor.red * 0.45).round())
              .withGreen((themeColor.green * 0.45).round())
              .withBlue((themeColor.blue * 0.45).round()),
          themeColorfulColor,
        ),
      ];

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

  @computed
  Color get textChoosed => _darkMode
      ? Colors.orangeAccent.shade400
      : Color.alphaBlend(
          Colors.orangeAccent.shade700,
          darkTheme,
        );

  @computed
  Color get ratingColor =>
      _darkMode ? Colors.yellow.shade800 : Colors.yellow.shade300;

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
