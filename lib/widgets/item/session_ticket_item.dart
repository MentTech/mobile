import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/models/common/program/program.dart';
import 'package:mobile/widgets/glassmorphism_widgets/glassmorphism_widget_button.dart';
import 'package:shimmer/shimmer.dart';

class SessionTicketItem extends StatelessWidget {
  const SessionTicketItem({
    Key? key,
    required this.program,
    this.callbackIfProgramNotNull,
    this.statusColor,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.blur = Properties.blur_glass_morphism,
    this.opacity = Properties.opacity_glass_morphism,
  }) : super(key: key);

  final Program? program;

  final double blur;
  final double opacity;

  final Color? statusColor;

  final EdgeInsets padding;
  final EdgeInsets margin;

  final VoidCallback? callbackIfProgramNotNull;

  @override
  Widget build(BuildContext context) {
    if (null != program) {
      return _buildAvailableItem(context, program!);
    }

    return _buildShimmerSessionTicketItem(context);
  }

  Container _buildAvailableItem(BuildContext context, Program program) {
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
          contentPadding: const EdgeInsets.symmetric(
            vertical: Dimens.small_vertical_padding,
            horizontal: Dimens.horizontal_padding,
          ),
          title: Container(
            margin: const EdgeInsets.only(bottom: Dimens.vertical_margin),
            child: Text(
              program.title,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          // subtitle: StarRateWidget(
          //   rateColor: Theme.of(context).selectedRowColor,
          //   rating: 3.5, //program.rate,
          // ),
          // ReadMoreText(
          //   program.detail,
          //   style: TextStyle(
          //     color: textColor ?? _themeStore.reverseThemeColor,
          //     fontSize: Dimens.small_text,
          //   ),
          //   trimLines: 1,
          //   trimMode: TrimMode.Line,
          //   moreStyle: TextStyle(
          //     color: textColor ?? _themeStore.reverseThemeColor,
          //     fontSize: Dimens.small_text,
          //   ),
          //   lessStyle: TextStyle(
          //     color: textColor ?? _themeStore.reverseThemeColor,
          //     fontSize: Dimens.small_text,
          //   ),
          // ),
          leading: Icon(
            Icons.loyalty_outlined,
            size: Dimens.large_text,
            color: statusColor ?? Theme.of(context).indicatorColor,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${program.credit} ",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              IconTheme(
                data: Theme.of(context)
                    .iconTheme
                    .copyWith(size: Dimens.medium_text),
                child: const Icon(Icons.token_rounded),
              ),
            ],
          ),
        ),
        blur: blur,
        opacity: opacity,
      ),
    );
  }

  Widget _buildShimmerSessionTicketItem(BuildContext context) {
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
              color: statusColor ?? Colors.white70,
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
      baseColor: Colors.white70,
      highlightColor: Theme.of(context).primaryColor,
      direction: ShimmerDirection.ltr,
    );
  }
}
