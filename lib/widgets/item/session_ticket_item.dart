import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/common/program/program.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/widgets/glassmorphism_widgets/glassmorphism_widget_button.dart';
import 'package:mobile/widgets/star_widget/start_rate_widget.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';

class SessionTicketItem extends StatelessWidget {
  SessionTicketItem({
    Key? key,
    required this.program,
    this.callbackIfProgramNotNull,
    this.textColor,
    this.statusColor,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.blur = Properties.blur_glass_morphism,
    this.opacity = Properties.opacity_glass_morphism,
  }) : super(key: key);

  final Program? program;

  final double blur;
  final double opacity;

  final Color? textColor;
  final Color? statusColor;

  final EdgeInsets padding;
  final EdgeInsets margin;

  final VoidCallback? callbackIfProgramNotNull;

  final ThemeStore _themeStore = getIt<ThemeStore>();

  @override
  Widget build(BuildContext context) {
    if (null != program) {
      return _buildAvailableItem(program!);
    }

    return _buildShimmerSessionTicketItem();
  }

  Widget _buildShimmerSessionTicketItem() {
    return Shimmer.fromColors(
      child: Container(
        height: 100,
        width: double.infinity,
        color: Colors.grey,
      ),
      baseColor: _themeStore.light,
      highlightColor: _themeStore.themeColorfulColor,
    );
  }

  Container _buildAvailableItem(Program program) {
    return Container(
      margin: margin,
      child: GlassmorphismWidgetButton(
        border: statusColor ?? Colors.white,
        background: statusColor ?? Colors.white,
        padding: padding,
        onTap: () {
          callbackIfProgramNotNull?.call();
        },
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                program.title,
                style: TextStyle(
                  color: Color.alphaBlend(
                      (textColor ?? _themeStore.themeColor).withAlpha(150),
                      Colors.white),
                  fontSize: Dimens.small_text,
                  fontWeight: FontWeight.w500,
                ),
              ),
              StarRateWidget(
                rateColor: _themeStore.ratingColor,
                rating: 3.5, //program.rate,
              ),
            ],
          ),
          subtitle: ReadMoreText(
            program.detail,
            style: TextStyle(
              color: textColor ?? _themeStore.themeColor,
              fontSize: Dimens.small_text,
            ),
            trimLines: 1,
            trimMode: TrimMode.Line,
          ),
          leading: Icon(
            Icons.loyalty_outlined,
            size: Dimens.large_text,
            color: statusColor ?? textColor ?? Colors.white70,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${program.credit} ",
                style: TextStyle(
                  color: textColor ?? _themeStore.themeColor,
                  fontSize: Dimens.small_text,
                ),
              ),
              Icon(
                Icons.token_rounded,
                size: Dimens.medium_text,
                color: textColor ?? _themeStore.themeColor,
              ),
            ],
          ),
        ),
        blur: blur,
        opacity: opacity,
      ),
    );
  }
}
