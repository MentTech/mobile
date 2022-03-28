import 'package:flutter/material.dart';
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
  bool get darkMode => _darkMode;

  double get opacityTheme => _darkMode ? 0.9 : 0.75;

  Color get textTitleColor =>
      _darkMode ? AppColors.darkTextTheme : AppColors.lightTextTheme;

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
