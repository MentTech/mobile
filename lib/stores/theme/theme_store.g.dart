// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ThemeStore on _ThemeStore, Store {
  Computed<bool>? _$darkModeComputed;

  @override
  bool get darkMode => (_$darkModeComputed ??=
          Computed<bool>(() => super.darkMode, name: '_ThemeStore.darkMode'))
      .value;
  Computed<String>? _$modeNameComputed;

  @override
  String get modeName => (_$modeNameComputed ??=
          Computed<String>(() => super.modeName, name: '_ThemeStore.modeName'))
      .value;
  Computed<String>? _$appIconComputed;

  @override
  String get appIcon => (_$appIconComputed ??=
          Computed<String>(() => super.appIcon, name: '_ThemeStore.appIcon'))
      .value;
  Computed<double>? _$opacityThemeComputed;

  @override
  double get opacityTheme =>
      (_$opacityThemeComputed ??= Computed<double>(() => super.opacityTheme,
              name: '_ThemeStore.opacityTheme'))
          .value;
  Computed<Color>? _$themeColorfulColorComputed;

  @override
  Color get themeColorfulColor => (_$themeColorfulColorComputed ??=
          Computed<Color>(() => super.themeColorfulColor,
              name: '_ThemeStore.themeColorfulColor'))
      .value;
  Computed<Color>? _$reverseThemeColorfulColorComputed;

  @override
  Color get reverseThemeColorfulColor =>
      (_$reverseThemeColorfulColorComputed ??= Computed<Color>(
              () => super.reverseThemeColorfulColor,
              name: '_ThemeStore.reverseThemeColorfulColor'))
          .value;
  Computed<Color>? _$themeColorComputed;

  @override
  Color get themeColor =>
      (_$themeColorComputed ??= Computed<Color>(() => super.themeColor,
              name: '_ThemeStore.themeColor'))
          .value;
  Computed<Color>? _$themeThemeColorComputed;

  @override
  Color get themeThemeColor => (_$themeThemeColorComputed ??= Computed<Color>(
          () => super.themeThemeColor,
          name: '_ThemeStore.themeThemeColor'))
      .value;
  Computed<Color>? _$reverseThemeColorComputed;

  @override
  Color get reverseThemeColor => (_$reverseThemeColorComputed ??=
          Computed<Color>(() => super.reverseThemeColor,
              name: '_ThemeStore.reverseThemeColor'))
      .value;
  Computed<List<Color>>? _$linearGradientColorsComputed;

  @override
  List<Color> get linearGradientColors => (_$linearGradientColorsComputed ??=
          Computed<List<Color>>(() => super.linearGradientColors,
              name: '_ThemeStore.linearGradientColors'))
      .value;
  Computed<List<Color>>? _$lineToLineGradientColorsComputed;

  @override
  List<Color> get lineToLineGradientColors =>
      (_$lineToLineGradientColorsComputed ??= Computed<List<Color>>(
              () => super.lineToLineGradientColors,
              name: '_ThemeStore.lineToLineGradientColors'))
          .value;
  Computed<List<Color>>? _$_lineToLineGradientColorsDarkComputed;

  @override
  List<Color> get _lineToLineGradientColorsDark =>
      (_$_lineToLineGradientColorsDarkComputed ??= Computed<List<Color>>(
              () => super._lineToLineGradientColorsDark,
              name: '_ThemeStore._lineToLineGradientColorsDark'))
          .value;
  Computed<List<Color>>? _$_lineToLineGradientColorsLightComputed;

  @override
  List<Color> get _lineToLineGradientColorsLight =>
      (_$_lineToLineGradientColorsLightComputed ??= Computed<List<Color>>(
              () => super._lineToLineGradientColorsLight,
              name: '_ThemeStore._lineToLineGradientColorsLight'))
          .value;
  Computed<Color>? _$textChoosedComputed;

  @override
  Color get textChoosed =>
      (_$textChoosedComputed ??= Computed<Color>(() => super.textChoosed,
              name: '_ThemeStore.textChoosed'))
          .value;
  Computed<Color>? _$ratingColorComputed;

  @override
  Color get ratingColor =>
      (_$ratingColorComputed ??= Computed<Color>(() => super.ratingColor,
              name: '_ThemeStore.ratingColor'))
          .value;

  late final _$_darkModeAtom =
      Atom(name: '_ThemeStore._darkMode', context: context);

  @override
  bool get _darkMode {
    _$_darkModeAtom.reportRead();
    return super._darkMode;
  }

  @override
  set _darkMode(bool value) {
    _$_darkModeAtom.reportWrite(value, super._darkMode, () {
      super._darkMode = value;
    });
  }

  late final _$changeBrightnessToDarkAsyncAction =
      AsyncAction('_ThemeStore.changeBrightnessToDark', context: context);

  @override
  Future<dynamic> changeBrightnessToDark(bool value) {
    return _$changeBrightnessToDarkAsyncAction
        .run(() => super.changeBrightnessToDark(value));
  }

  @override
  String toString() {
    return '''
darkMode: ${darkMode},
modeName: ${modeName},
appIcon: ${appIcon},
opacityTheme: ${opacityTheme},
themeColorfulColor: ${themeColorfulColor},
reverseThemeColorfulColor: ${reverseThemeColorfulColor},
themeColor: ${themeColor},
themeThemeColor: ${themeThemeColor},
reverseThemeColor: ${reverseThemeColor},
linearGradientColors: ${linearGradientColors},
lineToLineGradientColors: ${lineToLineGradientColors},
textChoosed: ${textChoosed},
ratingColor: ${ratingColor}
    ''';
  }
}
