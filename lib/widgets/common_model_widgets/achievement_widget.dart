import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/models/common/achievement/achievement.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';

class AchievementWidget extends StatelessWidget {
  const AchievementWidget({
    Key? key,
    required this.achievement,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.blur = Properties.blur_glass_morphism,
    this.opacity = Properties.opacity_glass_morphism,
  }) : super(key: key);

  final Achievement achievement;

  final double blur;
  final double opacity;

  final EdgeInsets padding;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: GlassmorphismContainer(
        padding: padding,
        child: ListTile(
          minLeadingWidth: 0,
          title: Text(
            achievement.title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            achievement.description,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          leading: IconTheme(
            data: Theme.of(context).iconTheme.copyWith(size: Dimens.large_text),
            child: const Icon(Icons.hotel_class_rounded),
          ),
        ),
        blur: blur,
        opacity: opacity,
      ),
    );
  }
}
