import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/models/common/skill/skill.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';

class SkillWidgetContainer extends StatelessWidget {
  const SkillWidgetContainer({
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
                foregroundColor: Theme.of(context).indicatorColor,
                backgroundColor:
                    Theme.of(context).indicatorColor.withOpacity(0.3),
                value: skill.abilityPercent,
                animationDuration: const Duration(
                  milliseconds: Properties.animatedTimeInMiliSecond,
                ),
                child: Center(
                  child: Text(
                    NumberFormat(".##%").format(skill.abilityPercent),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
            Text(
              skill.description ?? "Unknown",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.w500),
            )
          ],
        ),
        blur: Properties.blur_glass_morphism,
        opacity: Properties.opacity_glass_morphism,
      ),
    );
  }
}
