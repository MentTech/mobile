import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/notification/notification.dart';
import 'package:mobile/stores/notification/notification_store.dart';
import 'package:mobile/stores/notification/type_showing_notification.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/ui/home/page/subpage/notification_tag.dart';
import 'package:mobile/utils/application/application_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/background_colorful/linear_gradient_background.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:mobile/widgets/glassmorphism_widgets/glassmorphism_widget_button.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:mobile/utils/extension/datetime_extension.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({Key? key}) : super(key: key);

  // store:---------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final NotificationStore _notificationStore = getIt<NotificationStore>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        LinearGradientBackground(
          colors: _themeStore.lineToLineGradientColors,
          stops: null,
        ),
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.horizontal_padding,
                vertical: Dimens.vertical_padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)
                      .translate("notification_title_translate"),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: Dimens.extra_large_vertical_margin,
                  ),
                  child: _buildFilterNotificationButtons(context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context).translate("lastest"),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        _notificationStore.readAllUnreadedNotification();
                      },
                      child: Text(
                        AppLocalizations.of(context).translate("read_all"),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Theme.of(context).highlightColor),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: _buildNotificationView(context),
                ),
              ],
            ),
          ),
        ),
        Observer(
          builder: (_) {
            return !_notificationStore.success
                ? ApplicationUtils.showErrorMessage(
                    context,
                    "notification_center_notification_title_translate",
                    _notificationStore.getFailedMessageKey,
                  )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Observer _buildNotificationView(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        if (_notificationStore.isLoading) {
          return _buildShimmerLoading(context);
        } else {
          if (_notificationStore.hasNotification) {
            return _buildNotificationList(context);
          } else {
            return _buildNoNotification(context);
          }
        }
      },
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, __) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
          child: GlassmorphismContainer(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.horizontal_padding,
              vertical: Dimens.small_vertical_padding,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: ApplicationUtils.shimmerSection(
                    context,
                    child: Container(
                      height: Dimens.medium_text * 4,
                      width: Dimens.medium_text * 4,
                      decoration: const BoxDecoration(
                          color: Colors.black87, shape: BoxShape.circle),
                    ),
                  ),
                ),
                const SizedBox(
                  width: Dimens.extra_large_horizontal_margin,
                ),
                Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ApplicationUtils.shimmerSection(
                        context,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: Dimens.small_vertical_margin,
                          ),
                          height: Dimens.medium_text,
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: Dimens.kMaxBorderRadius,
                          ),
                        ),
                      ),
                      ApplicationUtils.shimmerSection(
                        context,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: Dimens.small_vertical_margin,
                          ),
                          height: Dimens.medium_text,
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: Dimens.kMaxBorderRadius,
                          ),
                        ),
                      ),
                      ApplicationUtils.shimmerSection(
                        context,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: Dimens.small_vertical_margin,
                          ),
                          height: Dimens.medium_text,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: Dimens.kMaxBorderRadius,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ApplicationUtils.shimmerSection(
                    context,
                    child: IconTheme(
                      data: Theme.of(context).iconTheme,
                      child: const Icon(Icons.fiber_manual_record_rounded),
                    ),
                  ),
                ),
              ],
            ),
            blur: Properties.blur_glass_morphism,
            opacity: Properties.opacity_glass_morphism,
            radius: Dimens.kBorderRadiusValue,
          ),
        );
      },
      itemCount: 5,
    );
  }

  Text _buildNoNotification(BuildContext context) {
    return Text(
      AppLocalizations.of(context).translate("no_notification"),
      style: Theme.of(context).textTheme.bodySmall,
    );
  }

  Widget _buildNotificationList(BuildContext context) {
    return Observer(
      builder: (_) {
        _notificationStore.trigger;
        return StickyGroupedListView<NotificationModel, DateTime>(
          elements: _notificationStore.getFilteredNotificationList,
          groupBy: (element) => element.createAt.today(toUTC: false),
          groupSeparatorBuilder: (NotificationModel groupByValue) {
            return _getGroupSeparator(groupByValue, context);
          },
          itemBuilder: (BuildContext context, NotificationModel element) =>
              NotificationTag(
                  notificationModel: element,
                  callback: () {
                    if (!element.isRead) {
                      _notificationStore.markNotificationAsRead(element.id);
                    }
                  }),
          itemComparator: (item1, item2) =>
              item1.createAt.compareTo(item2.createAt),
          groupComparator: (item1, item2) => item1.compareTo(item2),
          floatingHeader: true,
          order: StickyGroupedListOrder.DESC,
          physics: const BouncingScrollPhysics(),
        );
      },
    );
  }

  SizedBox _getGroupSeparator(
      NotificationModel groupByValue, BuildContext context) {
    return SizedBox(
      height: 50,
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            timeago.format(
              groupByValue.createAt,
              locale: AppLocalizations.of(context).locale.languageCode,
            ),
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterNotificationButtons(BuildContext context) {
    return Observer(
      builder: (_) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildSelectableButton(
              context,
              text: AppLocalizations.of(context).translate("all_translate"),
              isSelected: _notificationStore.notificationFilter ==
                  NotificationFilter.all,
              ontap: () {
                _notificationStore
                    .changeNotificationMethodFilter(NotificationFilter.all);
              },
            ),
            const SizedBox(
              width: Dimens.large_horizontal_margin,
            ),
            _buildSelectableButton(
              context,
              text: AppLocalizations.of(context)
                  .translate("unread_notification_translate"),
              isSelected: _notificationStore.notificationFilter ==
                  NotificationFilter.unread,
              ontap: () {
                _notificationStore
                    .changeNotificationMethodFilter(NotificationFilter.unread);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildSelectableButton(
    BuildContext context, {
    required String text,
    required VoidCallback ontap,
    required bool isSelected,
  }) {
    return GlassmorphismWidgetButton(
      width: null,
      padding: const EdgeInsets.symmetric(
        vertical: Dimens.vertical_padding,
        horizontal: Dimens.horizontal_padding,
      ),
      background:
          isSelected ? Theme.of(context).selectedRowColor : Colors.white,
      radius: Dimens.kBorderMaxRadiusValue,
      alignment: Alignment.center,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: isSelected
                  ? Color.alphaBlend(
                      Theme.of(context).selectedRowColor.withOpacity(0.7),
                      Theme.of(context).highlightColor)
                  : Color.alphaBlend(
                      Theme.of(context).highlightColor.withOpacity(0.7),
                      Theme.of(context).highlightColor,
                    ),
              fontWeight: isSelected ? FontWeight.w500 : null,
            ),
      ),
      onTap: ontap,
      blur: Properties.blur_glass_morphism,
      opacity: Properties.opacity_glass_morphism,
    );
  }
}
