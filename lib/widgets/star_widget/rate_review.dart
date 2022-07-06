import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';

class RateReview extends StatefulWidget {
  const RateReview({
    Key? key,
    required this.onReviewChange,
    this.rate = 0,
    this.padding = EdgeInsets.zero,
    this.canReact = true,
    this.chooseColor,
    this.sizeStar,
    this.mainAxisAlignment = MainAxisAlignment.spaceAround,
  }) : super(key: key);

  final EdgeInsets padding;
  final int rate;
  final bool canReact;
  final ValueChanged<int>? onReviewChange;
  final Color? chooseColor;
  final double? sizeStar;
  final MainAxisAlignment mainAxisAlignment;

  @override
  State<RateReview> createState() => _RateReviewState();
}

class _RateReviewState extends State<RateReview> {
  // state:---------------------------------------------------------------------
  int rate = 0;

  // store:---------------------------------------------------------------------

  // final state:---------------------------------------------------------------
  late final Color choosenColor;

  @override
  void initState() {
    super.initState();

    rate = widget.rate;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    choosenColor = widget.chooseColor ?? Theme.of(context).selectedRowColor;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: widget.mainAxisAlignment,
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
