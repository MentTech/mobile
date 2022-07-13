import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/models/mentor/mentor.dart';
import 'package:mobile/models/notification/notification.dart';
import 'package:mobile/stores/mentor/mentor_store.dart';
import 'package:mobile/ui/session_detail/session_detail_full_feature.dart';
import 'package:mobile/utils/application/application_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/widgets/container/image_container/network_image_widget.dart';
import 'package:mobile/widgets/errors_widget/error_widget.dart';
import 'package:mobile/widgets/glassmorphism_widgets/glassmorphism_widget_button.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationTag extends StatefulWidget {
  const NotificationTag({
    Key? key,
    required this.notificationModel,
    required this.callback,
  }) : super(key: key);

  final VoidCallback callback;
  final NotificationModel notificationModel;

  @override
  State<NotificationTag> createState() => _NotificationTagState();
}

class _NotificationTagState extends State<NotificationTag> {
  late final MentorStore _mentorStore;
  // late final NotificationModelStore _notificationModelStore;

  bool isRead = false;

  @override
  void initState() {
    super.initState();

    isRead = widget.notificationModel.isRead;

    // log("[notificaiton log] [initState] " +
    //     widget.notificationModel.message +
    //     " and isread: " +
    //     widget.notificationModel.isRead.toString());
    // _notificationModelStore = NotificationModelStore(widget.notificationModel);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // log("[notificaiton log] [didChangeDependencies] " +
    //     widget.notificationModel.message +
    //     " and isread: " +
    //     widget.notificationModel.isRead.toString());

    _mentorStore = Provider.of<MentorStore>(context, listen: false);
    // _mentorStore.fetchAMentor(widget.notificationModel.actorId);
  }

  @override
  void didUpdateWidget(covariant NotificationTag oldWidget) {
    super.didUpdateWidget(oldWidget);

    // log("[notificaiton log] [didUpdateWidget] " +
    //     widget.notificationModel.message +
    //     " and isread: " +
    //     widget.notificationModel.isRead.toString());

    isRead = widget.notificationModel.isRead;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
      child: GlassmorphismWidgetButton(
        onTap: () {
          widget.callback.call();

          // _notificationModelStore.read();
          setState(() {
            isRead = true;
          });

          Routes.route(
            context,
            SesstionDetailScreen(
              sessionId: widget.notificationModel.additional.sessionId,
            ),
          );
        },
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.horizontal_padding,
          vertical: Dimens.small_vertical_padding,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: FutureBuilder<MentorModel?>(
                future: futureFetchMentor(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ApplicationUtils.shimmerSection(
                      context,
                      child: Container(
                        height: Dimens.medium_text * 4,
                        width: Dimens.medium_text * 4,
                        decoration: const BoxDecoration(
                            color: Colors.black87, shape: BoxShape.circle),
                      ),
                    );
                  } else {
                    if (snapshot.hasError) {
                      return const ErrorContentWidget(
                          titleError: "", contentError: "");
                    } else {
                      return ClipOval(
                        child: NetworkImageWidget(
                          url: snapshot.data?.avatar,
                          radius: Dimens.medium_text * 4,
                        ),
                      );
                    }
                  }
                },
              ),
            ),
            const SizedBox(
              width: Dimens.extra_large_horizontal_margin,
            ),
            Expanded(
              flex: 8,
              child: Observer(builder: (_) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.notificationModel.message,
                      style: isRead
                          ? Theme.of(context).textTheme.bodySmall
                          : Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Theme.of(context).highlightColor,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Text(
                      timeago.format(
                        widget.notificationModel.createAt,
                        locale:
                            AppLocalizations.of(context).locale.languageCode,
                      ),
                      style: isRead
                          ? Theme.of(context).textTheme.bodySmall
                          : Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Theme.of(context).highlightColor,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ],
                );
              }),
            ),
            Expanded(
              flex: 1,
              child: SizedBox.shrink(
                child: isRead
                    ? null
                    : IconTheme(
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
  }

  Future<MentorModel?> futureFetchMentor() async {
    return await _mentorStore.responseMentor(widget.notificationModel.actorId);
  }
}
