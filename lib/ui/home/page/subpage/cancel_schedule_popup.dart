import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';

class CancelSchedulePopup extends StatelessWidget {
  const CancelSchedulePopup({Key? key, required this.scheduleDetailId})
      : super(key: key);

  final String scheduleDetailId;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: Dimens.kBorderRadius),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Container(
                // margin: const EdgeInsets.symmetric(
                //     vertical: Dimens.smallVerticalMargin),
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.vertical_padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.orange,
                    ),
                    // const SizedBox(
                    //   width: Dimens.smallVerticalMargin,
                    // ),
                    // Text(
                    //   AppLocalizations.of(context)
                    //       .translate("cancel_schedule_warning"),
                    //   style: TextStyle(
                    //       color: Theme.of(context).primaryColor,
                    //       fontSize: Dimens.smallText,
                    //       fontWeight: FontWeight.w500),
                    // ),
                  ],
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              // MyTextButton(
              //   text: AppLocalizations.of(context).translate("cancel"),
              //   fillColor: Colors.transparent,
              //   fontSizeText: Dimens.smallText,
              //   textColor: Theme.of(context).primaryColor,
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: Dimens.smallHorizontalPadding,
              //   ),
              //   onTap: () {
              //     Navigator.maybePop(context);
              //   },
              // ),
              // const SizedBox(
              //   width: Dimens.horizontalMargin,
              // ),
              // MyTextButton(
              //   text: AppLocalizations.of(context).translate("submit"),
              //   fillColor: Colors.transparent,
              //   fontSizeText: Dimens.smallText,
              //   textColor: Theme.of(context).primaryColor,
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: Dimens.smallHorizontalPadding,
              //   ),
              //   onTap: () {
              //     Provider.of<ScheduleStore>(context, listen: false)
              //         .deleteScheduleByScheduleDetailId(scheduleDetailId)
              //         .then((value) {
              //       if (value != null) {
              //         DeviceUtils.showSnackBar(context, value);
              //       }
              //       Navigator.maybePop(context);
              //     });
              //   },
              // )
            ],
          ),
        ],
      ),
    );
  }
}
