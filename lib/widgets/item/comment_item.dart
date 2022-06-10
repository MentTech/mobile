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
        leading: NetworkImageWidget(
          url: rateModel.user.avatar,
        ),
        title: Text(
          rateModel.user.name,
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                  vertical: Dimens.small_vertical_margin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RateReview(
                    onReviewChange: null,
                    canReact: false,
                    rate: rateModel.rating.round(),
                    chooseColor: Colors.yellow,
                    sizeStar: Dimens.lightly_medium_text,
                  ),
                  Text(
                    timeago.format(
                      rateModel.createAt,
                      locale: AppLocalizations.of(context).locale.languageCode,
                    ),
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            ReadMoreText(
              rateModel.comment,
              trimMode: TrimMode.Line,
              trimLines: 1,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
