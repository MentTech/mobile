import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/common/transaction/transaction.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mobile/utils/extension/datetime_extension.dart';
import 'package:mobile/stores/enum/transaction_type_enum.dart';
import 'package:mobile/stores/enum/status_type_enum.dart';

class TransactionTicketItem extends StatelessWidget {
  TransactionTicketItem({
    Key? key,
    required this.transaction,
    this.textColor,
    this.statusColor,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.blur = Properties.blur_glass_morphism,
    this.opacity = Properties.opacity_glass_morphism,
  }) : super(key: key);

  final Transaction? transaction;

  final double blur;
  final double opacity;

  final Color? textColor;
  final Color? statusColor;

  final EdgeInsets padding;
  final EdgeInsets margin;

  final ThemeStore _themeStore = getIt<ThemeStore>();

  @override
  Widget build(BuildContext context) {
    if (null != transaction) {
      return _buildAvailableItem(context, transaction!);
    }

    return _buildShimmerTransactionTicketItem();
  }

  Container _buildAvailableItem(BuildContext context, Transaction transaction) {
    return Container(
      margin: margin,
      child: GlassmorphismContainer(
        border: statusColor ?? transaction.status.toColorType(),
        background: statusColor ?? transaction.status.toColorType(),
        padding: padding,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: Dimens.small_vertical_margin),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: Dimens.vertical_padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)
                        .translate(transaction.type.toTranslateCode()),
                    style: TextStyle(
                      color: Color.alphaBlend(
                          (textColor ?? Theme.of(context).indicatorColor)
                              .withAlpha(150),
                          transaction.status.toColorType()),
                      fontSize: Dimens.small_text,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    transaction.createAt.toDateTimeDealString(),
                    style: TextStyle(
                      color: Color.alphaBlend(
                          (textColor ?? Theme.of(context).indicatorColor)
                              .withAlpha(150),
                          transaction.status.toColorType()),
                      fontSize: Dimens.small_text,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            subtitle: ReadMoreText(
              transaction.message,
              style: TextStyle(
                color: textColor ?? Theme.of(context).indicatorColor,
                fontSize: Dimens.small_text,
              ),
              trimLines: 1,
              trimMode: TrimMode.Line,
            ),
            leading: Icon(
              Icons.receipt_long_rounded,
              size: Dimens.large_text,
              color:
                  statusColor ?? textColor ?? transaction.status.toColorType(),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${transaction.amount} ",
                  style: TextStyle(
                    color: textColor ?? Theme.of(context).indicatorColor,
                    fontSize: Dimens.small_text,
                  ),
                ),
                Icon(
                  Icons.token_rounded,
                  size: Dimens.medium_text,
                  color: textColor ?? Theme.of(context).indicatorColor,
                ),
              ],
            ),
          ),
        ),
        blur: blur,
        opacity: opacity,
      ),
    );
  }

  Widget _buildShimmerTransactionTicketItem() {
    return Shimmer.fromColors(
      child: Container(
        margin: margin,
        child: GlassmorphismContainer(
          border: statusColor ?? Colors.white,
          background: statusColor ?? Colors.white,
          padding: const EdgeInsets.symmetric(
              vertical: Dimens.small_vertical_padding),
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
              Icons.receipt_long_rounded,
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
