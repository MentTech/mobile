import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/models/common/session/session.dart';
import 'package:mobile/stores/common/common_store.dart';
import 'package:mobile/ui/session_detail/session_detail_full_feature.dart';
import 'package:mobile/utils/extension/datetime_extension.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/widgets/button_widgets/rounded_button_widget.dart';
import 'package:mobile/widgets/dialog_showing/slider_dialog.dart';
import 'package:mobile/widgets/popup_template/field_popup.dart';
import 'package:mobile/widgets/popup_template/yes_no_popup.dart';
import 'package:mobile/widgets/star_widget/rate_review.dart';
import 'package:provider/provider.dart';

class EventCard extends StatefulWidget {
  const EventCard({
    Key? key,
    required this.session,
    // required this.onViewDetailTap,
    // required this.onSendMessageTap,
  }) : super(key: key);

  final Session session;
  // final VoidCallback onViewDetailTap;
  // final VoidCallback onSendMessageTap;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  // stored:--------------------------------------------------------------------
  late final CommonStore _commonStore;

  // text controller:-----------------------------------------------------------
  final TextEditingController commentReview = TextEditingController();

  // state variable:------------------------------------------------------------
  int rate = 0;
  late final Session _session;

  @override
  void initState() {
    super.initState();

    _session = widget.session;

    _commonStore = Provider.of<CommonStore>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
      child: Column(
        children: [
          _buildTitleName(),
          _buildContent(),
          const Divider(
            height: 1,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: Dimens.lightly_medium_vertical_margin,
          horizontal: Dimens.extra_large_horizontal_margin),
      padding: const EdgeInsets.symmetric(
          vertical: Dimens.vertical_padding,
          horizontal: Dimens.horizontal_padding),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            horizontalTitleGap: 0,
            minVerticalPadding: 0,
            leading: IconTheme(
              data: Theme.of(context)
                  .iconTheme
                  .copyWith(size: Dimens.extra_large_text),
              child: const Icon(
                Icons.price_change_outlined,
              ),
            ),
            title: Ink(
              child: InkWell(
                onTap: () {
                  Routes.route(
                    context,
                    SesstionDetailScreen(
                      sessionId: _session.id,
                    ),
                  );
                },
                child: Text(
                  _session.program.title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.star_rate_rounded,
                  color: Theme.of(context).selectedRowColor,
                  size: Dimens.medium_text,
                ),
                Text(
                  " ${_session.program.averageRating?.average ?? '0.0'}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${_session.program.credit} ",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                visible: _session.isAccepted && !_session.done,
                child: Row(
                  children: [
                    RoundedButtonWidget(
                      buttonText: AppLocalizations.of(context)
                          .translate('short_mark_as_done_translate'),
                      buttonColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        DialogPopupPresenter.showSlidePopupDialog<bool>(
                          context,
                          _buildMarkDonePopup(),
                          175,
                          300,
                          blur: Properties.medium_blur_glass_morphism,
                          opacity: Properties.medium_opacity_glass_morphism,
                        ).then(
                          (bool? isSend) {
                            if (isSend ?? false) {
                              _commonStore.markSessionOfProgramAsDone();
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      width: Dimens.horizontal_margin,
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _session.isAccepted &&
                    _session.done &&
                    _session.rating != null,
                child: Row(
                  children: [
                    RoundedButtonWidget(
                      buttonText: AppLocalizations.of(context)
                          .translate('short_review_about_session_translate'),
                      buttonColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        DialogPopupPresenter.showSlidePopupDialog<bool>(
                          context,
                          _buildReviewPopup(),
                          400,
                          300,
                          blur: Properties.medium_blur_glass_morphism,
                          opacity: Properties.medium_opacity_glass_morphism,
                        ).then(
                          (bool? isSend) {
                            if (isSend ?? false) {
                              _commonStore.reviewSessionOfProgram(
                                ReviewModel(
                                  rate: rate,
                                  comment: commentReview.text,
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      width: Dimens.horizontal_margin,
                    ),
                  ],
                ),
              ),
              // RoundedButtonWidget(
              //   buttonText:
              //       AppLocalizations.of(context).translate('view_detail'),
              //   buttonColor: Theme.of(context).primaryColor,
              //   onPressed: () {
              //     // onViewDetailTap.call();
              //     Routes.route(
              //       context,
              //       SesstionDetailScreen(
              //         sessionId: _session.id,
              //       ),
              //     );
              //   },
              // ),
              // const SizedBox(
              //   width: Dimens.horizontal_margin,
              // ),
              RoundedButtonWidget(
                buttonText: AppLocalizations.of(context).translate('message'),
                buttonColor: Theme.of(context).primaryColor,
                onPressed: () {
                  // onSendMessageTap.call();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row _buildTitleName() {
    return Row(
      children: [
        Container(
          width: 15,
          height: 10,
          decoration: BoxDecoration(
            color: Theme.of(context).highlightColor,
            borderRadius: const BorderRadiusDirectional.horizontal(
              end: Radius.circular(10),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
                left: Dimens.horizontal_padding,
                right: Dimens.extra_large_horizontal_padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: _session.expectedDate!
                            .toPresentedTime(toUTC: false),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).highlightColor,
                            ),
                      ),
                      TextSpan(
                        text:
                            ' ${_session.expectedDate!.toMeridiemPattern(toUTC: false).toLowerCase()}',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).highlightColor,
                            ),
                      ),
                    ],
                  ),
                ),
                // Text(
                //     '${_session.startTimestamp.toDifferentMinutes(_session.endTimestamp)} ${AppLocalizations.of(context).translate('minutes')}',
                //     style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildReviewPopup() {
    return FieldPopupTemplate(
      title: AppLocalizations.of(context).translate("review_title"),
      middleChild: RateReview(
        rate: rate,
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.large_horizontal_padding,
        ),
        onReviewChange: (int rate) {
          this.rate = rate;
        },
      ),
      fieldContents: [
        TextFieldContent(
          isObscure: false,
          textEditingController: commentReview,
          textInputType: TextInputType.multiline,
          hint: AppLocalizations.of(context).translate("your_review"),
          numberLines: 10,
        ),
      ],
    );
  }

  Widget _buildMarkDonePopup() {
    return YesNoPopup(
      child: ListTile(
        title: Text(
          AppLocalizations.of(context).translate("mark_session_as_done"),
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          AppLocalizations.of(context).translate("want_to_change_question"),
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.white70,
              ),
        ),
      ),
    );
  }
}
