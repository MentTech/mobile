import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/models/notification/notification.dart';
import 'package:mobile/stores/mentor/mentor_store.dart';
import 'package:mobile/utils/application/application_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/container/image_container/network_image_widget.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationTag extends StatefulWidget {
  const NotificationTag({
    Key? key,
    required this.notificationModel,
  }) : super(key: key);

  final NotificationModel notificationModel;

  @override
  State<NotificationTag> createState() => _NotificationTagState();
}

class _NotificationTagState extends State<NotificationTag> {
  late final MentorStore _mentorStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _mentorStore = Provider.of<MentorStore>(context, listen: false);
    _mentorStore.fetchAMentor(widget.notificationModel.actorId);
  }

  @override
  Widget build(BuildContext context) {
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
              child: _mentorStore.isLoading 
                  ? ApplicationUtils.shimmerSection(
                      context,
                      child: Container(
                        height: Dimens.medium_text * 4,
                        width: Dimens.medium_text * 4,
                        decoration: const BoxDecoration(
                            color: Colors.black87, shape: BoxShape.circle),
                      ),
                    )
                  : _mentorStore.hasMentor
                      ? ClipOval(
                          child: NetworkImageWidget(
                            url: _mentorStore.getMentor!.avatar,
                            radius: Dimens.medium_text * 4,
                          ),
                        )
                      : const SizedBox.shrink(),
            ),
            const SizedBox(
              width: Dimens.extra_large_horizontal_margin,
            ),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.notificationModel.message,
                    style: widget.notificationModel.isRead
                        ? Theme.of(context).textTheme.bodySmall
                        : Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).highlightColor,
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                  Text(
                    timeago.format(
                      widget.notificationModel.createAt,
                      locale: AppLocalizations.of(context).locale.languageCode,
                    ),
                    style: widget.notificationModel.isRead
                        ? Theme.of(context).textTheme.bodySmall
                        : Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).highlightColor,
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: widget.notificationModel.isRead
                  ? const SizedBox.shrink()
                  : IconTheme(
                      data: Theme.of(context).iconTheme,
                      child: const Icon(Icons.fiber_manual_record_rounded),
                    ),
            ),
          ],
        ),
        blur: Properties.blur_glass_morphism,
        opacity: Properties.opacity_glass_morphism,
        radius: Dimens.kBorderRadiusValue,
      ),
    );
  }
}
