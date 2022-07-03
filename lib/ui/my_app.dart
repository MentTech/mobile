import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/app_theme.dart';
import 'package:mobile/data/repository.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/authen/authen_store.dart';
import 'package:mobile/stores/common/common_store.dart';
import 'package:mobile/stores/language/language_store.dart';
import 'package:mobile/stores/mentor/mentor_store.dart';
import 'package:mobile/stores/search_store.dart/search_store.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/ui/splash/splash.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  // final ThemeStore _themeStore = ThemeStore(getIt<Repository>());
  // final LanguageStore _languageStore = LanguageStore(getIt<Repository>());
  final AuthenStore _authenStore = AuthenStore(getIt<Repository>());
  final UserStore _userStore = UserStore(getIt<Repository>());
  final MentorStore _mentorStore = MentorStore(getIt<Repository>());
  final CommonStore _commonStore = CommonStore(getIt<Repository>());
  final SearchStore _searchStore = SearchStore(getIt<Repository>());

  final ThemeStore _themeStore = getIt<ThemeStore>();
  final LanguageStore _languageStore = getIt<LanguageStore>();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenStore>(create: (_) => _authenStore),
        Provider<UserStore>(create: (_) => _userStore),
        Provider<MentorStore>(create: (_) => _mentorStore),
        Provider<CommonStore>(create: (_) => _commonStore),
        Provider<SearchStore>(create: (_) => _searchStore),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (_) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: DeviceUtils.packageInfo!.appName, //Strings.appName,
            theme: _themeStore.darkMode ? themeDataDark : themeData,
            routes: Routes.routes,
            locale: Locale(_languageStore.locale),
            supportedLocales: _languageStore.supportedLanguages
                .map((language) => Locale(language.locale!, language.code))
                .toList(),
            localizationsDelegates: const [
              // A class which loads the translations from JSON files
              AppLocalizations.delegate,
              // Built-in localization of basic text for Material widgets
              GlobalMaterialLocalizations.delegate,
              // Built-in localization for text direction LTR/RTL
              GlobalWidgetsLocalizations.delegate,
              // Built-in localization of basic text for Cupertino widgets
              GlobalCupertinoLocalizations.delegate,
            ],
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
