import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/language/language.dart';
import 'package:mobile/stores/language/language_store.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:mobile/widgets/popup_template/hero_popup_routes.dart';
import 'package:mobile/widgets/template/glassmorphism_appbar_only.dart';

class AdvancedSettings extends StatelessWidget {
  AdvancedSettings({Key? key}) : super(key: key);

  final ThemeStore _themeStore = getIt<ThemeStore>();
  final LanguageStore _languageStore = getIt<LanguageStore>();

  @override
  Widget build(BuildContext context) {
    return GlassmorphismGradientScaffoldAppbar(
      safeAreaTop: true,
      appbarName:
          AppLocalizations.of(context).translate("advanced_settings_translate"),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: kBottomNavigationBarHeight + Dimens.large_vertical_margin,
            ),
            _buildLanguageSession(context),
            const SizedBox(
              height: Dimens.large_vertical_margin,
            ),
            _buildThemeSession(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSession(BuildContext context) {
    return HeroPopupRoute<Language>(
      colorSourceCard: Colors.transparent,
      colorDestinationCard: Colors.transparent,
      sourceChild: GlassmorphismContainer(
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
          leading: Icon(
            Icons.translate,
            color: Theme.of(context).indicatorColor,
          ),
          title: Text(
            AppLocalizations.of(context).translate("home_tv_choose_language"),
            style: TextStyle(
              fontSize: Dimens.lightly_medium_text,
              color: Theme.of(context).indicatorColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            _languageStore.getLanguage() ??
                AppLocalizations.of(context).translate("unknown_translate"),
            style: TextStyle(
              fontSize: Dimens.small_text,
              color: Theme.of(context).indicatorColor,
            ),
          ),
        ),
        blur: Properties.hevily_blur_glass_morphism,
        opacity: Properties.hevily_opacity_glass_morphism,
      ),
      destinationChild: LanguagePopup(
        spLangs: _languageStore.supportedLanguages,
        selectLocale: _languageStore.locale,
        darkMode: _themeStore.darkMode,
      ),
      callback: (lang) {
        if (lang != null) {
          _languageStore.changeLanguage(lang.locale!);
        }
      },
    );
  }

  Widget _buildThemeSession(BuildContext context) {
    return HeroPopupRoute<ThemeModeItem>(
      colorSourceCard: Colors.transparent,
      colorDestinationCard: Colors.transparent,
      sourceChild: GlassmorphismContainer(
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
          leading: Icon(
            Icons.settings_display_outlined,
            color: Theme.of(context).indicatorColor,
          ),
          title: Text(
            AppLocalizations.of(context).translate("home_tv_choose_theme"),
            style: TextStyle(
              fontSize: Dimens.lightly_medium_text,
              color: Theme.of(context).indicatorColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            _themeStore.modeName,
            style: TextStyle(
              fontSize: Dimens.small_text,
              color: Theme.of(context).indicatorColor,
            ),
          ),
        ),
        blur: Properties.hevily_blur_glass_morphism,
        opacity: Properties.hevily_opacity_glass_morphism,
      ),
      destinationChild: ThemePopup(
        spThemes: [
          ThemeModeItem(mode: "Dark Mode", val: true),
          ThemeModeItem(mode: "Light Mode", val: false),
        ],
        selectTheme: _themeStore.darkMode,
      ),
      callback: (themeMode) {
        if (themeMode != null) {
          _themeStore.changeBrightnessToDark(themeMode.val!);
        }
      },
    );
  }
}

class LanguagePopup extends StatelessWidget {
  LanguagePopup({
    Key? key,
    required this.spLangs,
    required this.selectLocale,
    required this.darkMode,
  }) : super(key: key);

  final List<Language> spLangs;
  final String selectLocale;
  final bool darkMode;

  final ThemeStore _themeStore = getIt<ThemeStore>();

  @override
  Widget build(BuildContext context) {
    return GlassmorphismContainer(
      blur: Properties.blur_glass_morphism,
      opacity: Properties.opacity_glass_morphism,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin:
                const EdgeInsets.symmetric(vertical: Dimens.vertical_padding),
            padding:
                const EdgeInsets.symmetric(horizontal: Dimens.vertical_padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.translate,
                  color: Theme.of(context).indicatorColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  AppLocalizations.of(context)
                      .translate("home_tv_choose_language"),
                  style: TextStyle(
                    color: Theme.of(context).indicatorColor,
                    fontSize: Dimens.medium_text,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 0.5,
            color: Color.alphaBlend(
              Theme.of(context).primaryColor.withAlpha(100),
              Theme.of(context).indicatorColor,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: spLangs
                  .map(
                    (object) => ListTile(
                      dense: true,
                      title: Text(
                        object.language!,
                        style: TextStyle(
                          fontSize: Dimens.small_text,
                          color: selectLocale == object.locale
                              ? Theme.of(context).indicatorColor
                              : _themeStore.themeColor,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).maybePop<Language?>(object);
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ThemeModeItem {
  /// Name of Theme mode
  String? mode;

  /// value of mode
  bool? val;

  ThemeModeItem({this.mode, this.val});
}

class ThemePopup extends StatelessWidget {
  ThemePopup({
    Key? key,
    required this.spThemes,
    required this.selectTheme,
  }) : super(key: key);

  final List<ThemeModeItem> spThemes;
  final bool selectTheme;

  final ThemeStore _themeStore = getIt<ThemeStore>();

  @override
  Widget build(BuildContext context) {
    return GlassmorphismContainer(
      blur: Properties.blur_glass_morphism,
      opacity: Properties.opacity_glass_morphism,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              margin:
                  const EdgeInsets.symmetric(vertical: Dimens.vertical_padding),
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.vertical_padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.settings_display_outlined,
                    color: Theme.of(context).indicatorColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)
                        .translate("home_tv_choose_theme"),
                    style: TextStyle(
                      color: Theme.of(context).indicatorColor,
                      fontSize: Dimens.medium_text,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )),
          Divider(
            thickness: 0.5,
            color: Color.alphaBlend(
              Theme.of(context).primaryColor.withAlpha(100),
              Theme.of(context).indicatorColor,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: spThemes
                  .map(
                    (object) => ListTile(
                      dense: true,
                      title: Text(
                        object.mode!,
                        style: TextStyle(
                          color: selectTheme == object.val
                              ? Theme.of(context).indicatorColor
                              : _themeStore.themeColor,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).maybePop<ThemeModeItem?>(object);
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
