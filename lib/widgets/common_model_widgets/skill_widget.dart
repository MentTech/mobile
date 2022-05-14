import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/common/skill/skill.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';

class SkillWidgetContainer extends StatelessWidget {
  SkillWidgetContainer({
    Key? key,
    required this.width,
    required this.skill,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  final double width;
  final Skill skill;
  final EdgeInsets padding;
  final EdgeInsets margin;

  final ThemeStore _themeStore = getIt<ThemeStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: GlassmorphismContainer(
        padding: padding,
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.large_horizontal_padding,
                vertical: Dimens.vertical_padding,
              ),
              child: CircleProgressBar(
                foregroundColor: _themeStore.themeColor,
                backgroundColor: _themeStore.themeColor.withOpacity(0.3),
                value: skill.abilityPercent,
                animationDuration: const Duration(
                  milliseconds: Properties.animatedTimeInMiliSecond,
                ),
                child: Center(
                  child: Text(
                    NumberFormat(".##%").format(skill.abilityPercent),
                    style: TextStyle(
                      fontSize: Dimens.medium_text,
                      color: _themeStore.themeColor,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              skill.description ?? "Unknown",
              style: TextStyle(
                fontSize: Dimens.small_text,
                fontWeight: FontWeight.w500,
                color: _themeStore.themeColor,
              ),
            )
          ],
        ),
        blur: Properties.blur_glass_morphism,
        opacity: Properties.opacity_glass_morphism,
      ),
    );
  }
}
