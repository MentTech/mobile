import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/models/rate/rate.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/container/image_container/network_image_widget.dart';
import 'package:mobile/widgets/star_widget/rate_review.dart';
import 'package:readmore/readmore.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentItem extends StatelessWidget {
  const CommentItem({
    Key? key,
    required this.rateModel,
  }) : super(key: key);

  final RateModel rateModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.horizontal_padding,
        vertical: Dimens.vertical_padding,
      ),
      child: ListTile(
        leading: ClipOval(
          child: NetworkImageWidget(
            url: rateModel.user?.avatar,
          ),
        ),
        title: Text(
          rateModel.user?.name ??
              AppLocalizations.of(context).translate("unknown_translate"),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RateReview(
              onReviewChange: null,
              canReact: false,
              rate: rateModel.rating.round(),
              chooseColor: Theme.of(context).selectedRowColor,
              sizeStar: Dimens.lightly_medium_text,
              mainAxisAlignment: MainAxisAlignment.start,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                  vertical: Dimens.small_vertical_margin),
              child: Text(
                timeago.format(
                  rateModel.createAt,
                  locale: AppLocalizations.of(context).locale.languageCode,
                ),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            ReadMoreText(
              rateModel.comment,
              trimMode: TrimMode.Line,
              trimLines: 1,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
