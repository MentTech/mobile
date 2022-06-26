import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/models/common/experience/experience.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:readmore/readmore.dart';
import 'package:mobile/utils/extension/datetime_extension.dart';

class ExperienceWidget extends StatelessWidget {
  const ExperienceWidget({
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
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: Dimens.small_vertical_margin,
              ),
              Text(
                (null != experience.startAt
                        ? experience.startAt!.toMMMMYYYYLocaleString(context)
                        : AppLocalizations.of(context)
                            .translate("unknown_translate")) +
                    " - " +
                    (null != experience.endAt
                        ? experience.endAt!.toMMMMYYYYLocaleString(context)
                        : AppLocalizations.of(context)
                            .translate("present_translate")),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: Dimens.small_vertical_margin,
              ),
              Text(
                experience.company ??
                    AppLocalizations.of(context).translate("unknown_translate"),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: Dimens.vertical_margin,
              ),
            ],
          ),
          subtitle: ReadMoreText(
            experience.description ?? "",
            style: Theme.of(context).textTheme.bodySmall,
            trimLines: 1,
            trimMode: TrimMode.Line,
            moreStyle: Theme.of(context).textTheme.bodySmall,
            lessStyle: Theme.of(context).textTheme.bodySmall,
          ),
          leading: IconTheme(
            data: Theme.of(context).iconTheme.copyWith(size: Dimens.large_text),
            child: const Icon(Icons.apartment_rounded),
          ),
        ),
        blur: blur,
        opacity: opacity,
      ),
    );
  }
}
