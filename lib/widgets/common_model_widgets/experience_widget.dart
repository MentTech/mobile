import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/common/experience/experience.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:readmore/readmore.dart';

class ExperienceWidget extends StatelessWidget {
  ExperienceWidget({
    Key? key,
    required this.experience,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.blur = Properties.blur_glass_morphism,
    this.opacity = Properties.opacity_glass_morphism,
  }) : super(key: key);

  final Experience experience;

  final double blur;
  final double opacity;

  final EdgeInsets padding;
  final EdgeInsets margin;

  final ThemeStore _themeStore = getIt<ThemeStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: GlassmorphismContainer(
        padding: padding,
        child: ListTile(
          minLeadingWidth: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                experience.title ??
                    AppLocalizations.of(context).translate("unknown_translate"),
                style: TextStyle(
                  color: _themeStore.reverseThemeColor,
                  fontSize: Dimens.lightly_medium_text,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: Dimens.small_vertical_margin,
              ),
              Text(
                "June 2021 - Hiện tại",
                style: TextStyle(
                  color: _themeStore.reverseThemeColor,
                  fontSize: Dimens.small_text,
                ),
              ),
              const SizedBox(
                height: Dimens.small_vertical_margin,
              ),
              Text(
                "APTECH Computer Education",
                style: TextStyle(
                  color: _themeStore.reverseThemeColor,
                  fontSize: Dimens.small_text,
                ),
              ),
              const SizedBox(
                height: Dimens.vertical_margin,
              ),
            ],
          ),
          subtitle: ReadMoreText(
            experience.description ?? "",
            style: TextStyle(
              color: _themeStore.reverseThemeColor,
              fontSize: Dimens.small_text,
            ),
            trimLines: 1,
            trimMode: TrimMode.Line,
            moreStyle: TextStyle(
              color: _themeStore.reverseThemeColor,
              fontSize: Dimens.small_text,
            ),
            lessStyle: TextStyle(
              color: _themeStore.reverseThemeColor,
              fontSize: Dimens.small_text,
            ),
          ),
          leading: Icon(
            Icons.apartment_rounded,
            size: Dimens.large_text,
            color: _themeStore.reverseThemeColor,
          ),
        ),
        blur: blur,
        opacity: opacity,
      ),
    );
  }
}
