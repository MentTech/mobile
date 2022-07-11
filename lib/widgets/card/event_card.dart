import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/models/common/session/session.dart';
import 'package:mobile/ui/session_detail/session_detail_full_feature.dart';
import 'package:mobile/utils/extension/datetime_extension.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/widgets/button_widgets/rounded_button_widget.dart';

class EventCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
      child: Column(
        children: [
          _buildTitleName(context),
          _buildContent(context),
          const Divider(
            height: 1,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
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
              data: Theme.of(context).iconTheme,
              child: const Icon(
                Icons.price_change_outlined,
              ),
            ),
            title: Text(
              AppLocalizations.of(context).translate('price_translate'),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              session.program.credit.toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RoundedButtonWidget(
                buttonText:
                    AppLocalizations.of(context).translate('view_detail'),
                buttonColor: Theme.of(context).primaryColor,
                onPressed: () {
                  // onViewDetailTap.call();
                  Routes.route(
                    context,
                    SesstionDetailScreen(
                      sessionId: session.id,
                    ),
                  );
                },
              ),
              const SizedBox(
                width: Dimens.horizontal_margin,
              ),
              RoundedButtonWidget(
                buttonText:
                    AppLocalizations.of(context).translate('send_message'),
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

  Row _buildTitleName(BuildContext context) {
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
                        text:
                            session.expectedDate!.toPresentedTime(toUTC: true),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).highlightColor,
                            ),
                      ),
                      TextSpan(
                        text:
                            ' ${session.expectedDate!.toMeridiemPattern(toUTC: true).toLowerCase()}',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).highlightColor,
                            ),
                      ),
                    ],
                  ),
                ),
                // Text(
                //     '${session.startTimestamp.toDifferentMinutes(session.endTimestamp)} ${AppLocalizations.of(context).translate('minutes')}',
                //     style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        )
      ],
    );
  }
}
