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

  Widget _buildShimmerSessionTicketItem() {
    return Shimmer.fromColors(
      child: Container(
        margin: margin,
        child: GlassmorphismWidgetButton(
          border: statusColor ?? Colors.white,
          background: statusColor ?? Colors.white,
          padding: const EdgeInsets.symmetric(
              vertical: Dimens.small_vertical_padding),
          onTap: () {
            callbackIfProgramNotNull?.call();
          },
          child: ListTile(
            dense: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  height: Dimens.medium_text,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: Dimens.kMaxBorderRadius,
                  ),
                ),
                const SizedBox(height: Dimens.vertical_margin),
                Container(
                  width: 80,
                  height: Dimens.medium_text,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: Dimens.kMaxBorderRadius,
                  ),
                ),
              ],
            ),
            subtitle: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: Dimens.large_vertical_margin),
              height: Dimens.medium_text,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: Dimens.kMaxBorderRadius,
              ),
            ),
            leading: Icon(
              Icons.loyalty_outlined,
              size: Dimens.large_text,
              color: statusColor ?? textColor ?? Colors.white70,
            ),
            trailing: Container(
              width: 40,
              height: Dimens.large_text,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: Dimens.kMaxBorderRadius,
              ),
            ),
          ),
          blur: blur,
          opacity: opacity,
        ),
      ),
      baseColor: _themeStore.light,
      highlightColor: _themeStore.themeColorfulColor,
      direction: ShimmerDirection.ltr,
    );
  }
}

class CardListItem extends StatelessWidget {
  const CardListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),
          const SizedBox(height: 16),
          _buildText(),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            'https://flutter'
            '.dev/docs/cookbook/img-files/effects/split-check/Food1.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: 250,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ],
    );
  }
}
