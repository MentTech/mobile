import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ApplicationUtils {
  static Row buildFetchWidget(
      BuildContext context, IconData icon, String fetchStatusStr) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Theme.of(context).primaryColor,
          size: Dimens.large_text,
        ),
        const SizedBox(
          width: Dimens.horizontal_margin,
        ),
        Text(
          fetchStatusStr,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: Dimens.small_text,
          ),
        )
      ],
    );
  }

  static CustomFooter fetchFooterStatus() {
    return CustomFooter(
      height: kBottomNavigationBarHeight * 2,
      builder: (BuildContext context, LoadStatus? mode) {
        String text;
        IconData iconData;
        if (mode == LoadStatus.idle) {
          iconData = Icons.done_rounded;
          text = AppLocalizations.of(context).translate("load_idle");
        }
        // else if (mode == LoadStatus.loading) {
        //   iconData = Icons.done_rounded;
        //   text = AppLocalizations.of(context)
        //       .translate("load_loading");
        //   // body = CircularProgressIndicator();
        // }
        else if (mode == LoadStatus.failed) {
          iconData = Icons.sync_problem_rounded;
          text = AppLocalizations.of(context).translate("load_failed");
        } else if (mode == LoadStatus.canLoading) {
          iconData = Icons.published_with_changes_rounded;
          text = AppLocalizations.of(context).translate("load_canloading");
        } else {
          iconData = Icons.download_done_rounded;
          text = AppLocalizations.of(context).translate("load_else");
        }
        return SizedBox(
          height: 55.0,
          child: Center(
              child: mode == LoadStatus.loading
                  ? const CircularProgressIndicator()
                  : buildFetchWidget(context, iconData, text)),
        );
      },
    );
  }

  static WaterDropHeader fetchHeaderStatus(BuildContext context) {
    return WaterDropHeader(
      waterDropColor: Theme.of(context).primaryColor,
      complete: buildFetchWidget(
        context,
        Icons.done_rounded,
        AppLocalizations.of(context).translate("load_success"),
      ),
    );
  }
}
