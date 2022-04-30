import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/common/program/program.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/ui/mentor_detail/mentor_profile.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:readmore/readmore.dart';

class SessionTicketItem extends StatelessWidget {
  SessionTicketItem({
    Key? key,
    required this.program,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  final Program program;

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
          title: Text(
            program.title,
            style: TextStyle(
              color: _themeStore.themeColor,
              fontSize: Dimens.small_text,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: ReadMoreText(
            program.detail,
            style: TextStyle(
              color: _themeStore.themeColor,
              fontSize: Dimens.small_text,
            ),
            trimLines: 1,
            trimMode: TrimMode.Line,
          ),
          leading: Icon(
            Icons.loyalty_outlined,
            size: Dimens.large_text,
            color: _themeStore.themeColor,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${program.credit} ",
                style: TextStyle(
                  color: _themeStore.themeColor,
                  fontSize: Dimens.small_text,
                ),
              ),
              Icon(
                Icons.token_rounded,
                size: Dimens.medium_text,
                color: _themeStore.themeColor,
              ),
            ],
          ),
        ),
        blur: Properties.blur_glass_morphism,
        opacity: Properties.opacity_glass_morphism,
      ),
    );
  }
}
