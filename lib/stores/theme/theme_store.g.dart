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
lineToLineGradientColors: ${lineToLineGradientColors}
    ''';
  }
}
