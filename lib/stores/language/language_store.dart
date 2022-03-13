import 'package:mobile/data/repository.dart';
import 'package:mobile/models/language/language.dart';
import 'package:mobx/mobx.dart';

part 'language_store.g.dart';

class LanguageStore = _LanguageStore with _$LanguageStore;

abstract class _LanguageStore with Store {
  // ignore: constant_identifier_names, unused_field
  static const String TAG = "LanguageStore";

  // repository instance
  final Repository _repository;

  // store for handling errors

  // supported languages
  List<Language> supportedLanguages = [
    Language(code: 'US', locale: 'en', language: 'English'),
    Language(code: 'VN', locale: 'vi', language: 'Tiếng Việt'),
  ];

  // constructor:---------------------------------------------------------------
  _LanguageStore(Repository repository) : _repository = repository {
    init();
  }

  // store variables:-----------------------------------------------------------
  @observable
  String _locale = "en";

  @computed
  String get locale => _locale;

  // actions:-------------------------------------------------------------------
  @action
  void changeLanguage(String value) {
    _locale = value;
    _repository.changeLanguage(value).then((_) {
      // write additional logic here
    });
  }

  @action
  String getCode() {
    String code = "";

    if (_locale == 'en') {
      code = "US";
    } else if (_locale == 'vi') {
      code = "VN";
    }

    return code;
  }

  @action
  String? getLanguage() {
    return supportedLanguages[supportedLanguages
            .indexWhere((language) => language.locale == _locale)]
        .language;
  }

  // general:-------------------------------------------------------------------
  void init() async {
    // getting current language from shared preference
    if (_repository.currentLanguage != null) {
      _locale = _repository.currentLanguage!;
    }
  }

  // dispose:-------------------------------------------------------------------
  @override
  // ignore: override_on_non_overriding_member
  dispose() {}
}
