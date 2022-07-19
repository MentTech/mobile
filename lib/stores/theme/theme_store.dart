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
  List<Color> get lineToLineGradientColors =>
      darkMode ? _lineToLineGradientColorsDark : _lineToLineGradientColorsLight;

  @computed
  List<Color> get _lineToLineGradientColorsDark => [
        Colors.black87,
        AppColors.darkTextTheme,
        Colors.black87,
      ];

  @computed
  List<Color> get _lineToLineGradientColorsLight => [
        Color.alphaBlend(
          AppColors.lightTextTheme.withOpacity(0.3),
          Colors.white,
        ),
        Color.alphaBlend(
          AppColors.lightTextTheme.withOpacity(0.5),
          Colors.white,
        ),
        Color.alphaBlend(
          AppColors.lightTextTheme.withOpacity(0.3),
          Colors.white,
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
