import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/theme/theme_store.dart';

class RateReview extends StatefulWidget {
  const RateReview({
    Key? key,
    required this.onReviewChange,
    this.rate = 0,
    this.padding = EdgeInsets.zero,
    this.canReact = true,
    this.chooseColor,
    this.sizeStar,
  }) : super(key: key);

  final EdgeInsets padding;
  final int rate;
  final bool canReact;
  final ValueChanged<int>? onReviewChange;
  final Color? chooseColor;
  final double? sizeStar;

  @override
  State<RateReview> createState() => _RateReviewState();
}

class _RateReviewState extends State<RateReview> {
  // state:---------------------------------------------------------------------
  int rate = 0;

  // store:---------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();

  // final state:---------------------------------------------------------------
  late final Color choosenColor;

  @override
  void initState() {
    super.initState();

    rate = widget.rate;
    choosenColor = widget.chooseColor ?? _themeStore.lightThemeColor;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          5,
          (index) => _buildStarButton(
            isRated: rate > index,
            callback: widget.canReact
                ? () {
                    setState(() {
                      rate = index + 1;
                      widget.onReviewChange?.call(rate);
                    });
                  }
                : null,
          ),
        ),
      ),
    );
  }

  Widget _buildStarButton({
    required bool isRated,
    required VoidCallback? callback,
  }) {
    return IconButton(
      splashColor: Colors.white12,
      splashRadius: Dimens.medium_text,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      onPressed: () {
        callback?.call();
      },
      icon: Icon(
        Icons.star,
        color: isRated ? choosenColor : Colors.white70,
        size: widget.sizeStar ?? Dimens.large_text,
      ),
    );
  }
}
