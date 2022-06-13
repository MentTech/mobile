import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/common/session/session.dart';
import 'package:mobile/stores/enum/session_status_enum.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/ui/session_detail/session_detail.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/widgets/app_icon_widget.dart';
import 'package:mobile/widgets/background_colorful/linear_gradient_background.dart';
import 'package:mobile/widgets/glassmorphism_widgets/glassmorphism_widget_button.dart';
import 'package:mobile/widgets/item/session_ticket_item.dart';
import 'package:mobile/widgets/shimmer_loading_effect/listtile_item_shimmer.dart';
import 'package:provider/provider.dart';

class BalancedProfile extends StatefulWidget {
  const BalancedProfile({Key? key}) : super(key: key);

  @override
  State<BalancedProfile> createState() => _BalancedProfileState();
}

class _BalancedProfileState extends State<BalancedProfile> {
  // controller:----------------------------------------------------------------
  final DraggableScrollableController _draggableScrollableController =
      DraggableScrollableController();

  // store:---------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();
  late final UserStore _userStore;
  late double deviceHeight;

  @override
  void initState() {
    super.initState();

    _userStore = Provider.of<UserStore>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userStore.fetchUserSessions();

    deviceHeight = DeviceUtils.getScaledHeight(context, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    double minChildSize = kBottomNavigationBarHeight *
        2 /
        DeviceUtils.getScaledHeight(context, 1.0);
    double maxChildSize = 0.85 - minChildSize;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          LinearGradientBackground(
            colors: [
              _themeStore.themeColor,
              Colors.black
                  .withGreen((_themeStore.themeColor.green * 0.2).round())
                  .withBlue((_themeStore.themeColor.blue * 0.2).round()),
            ],
            stops: const [0, 0.35],
          ),
          SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildMainWidget(),
              ],
            ),
          ),
          DraggableScrollableSheet(
            controller: _draggableScrollableController,
            minChildSize: minChildSize,
            maxChildSize: maxChildSize,
            builder: (_, scrollController) {
              return Material(
                elevation: 10,
                color: Colors.black
                    .withGreen((_themeStore.themeColor.green * 0.5).round())
                    .withBlue((_themeStore.themeColor.blue * 0.5).round()),
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.white12,
                  ),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 5,
                      width: 50,
                      margin: const EdgeInsets.only(
                        top: Dimens.lightly_medium_vertical_margin,
                        bottom: Dimens.large_vertical_margin,
                      ),
                      decoration: BoxDecoration(
                        color: _themeStore.reverseThemeColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Observer(
                      builder: (_) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildSelectedButton(
                              iconData: Icons.clear_all,
                              text: "All",
                              isSelected:
                                  _userStore.currentSessionFetchStatus ==
                                      SessionStatus.all,
                              ontap: () {
                                _userStore
                                    .updateSessionStatus(SessionStatus.all);
                              },
                            ),
                            _buildSelectedButton(
                              iconData: Icons.pending_actions,
                              text: "Waiting",
                              isSelected:
                                  _userStore.currentSessionFetchStatus ==
                                      SessionStatus.waiting,
                              ontap: () {
                                _userStore
                                    .updateSessionStatus(SessionStatus.waiting);
                              },
                            ),
                            _buildSelectedButton(
                              iconData: Icons.recommend,
                              text: "Confirmed",
                              isSelected:
                                  _userStore.currentSessionFetchStatus ==
                                      SessionStatus.confirmed,
                              ontap: () {
                                _userStore.updateSessionStatus(
                                    SessionStatus.confirmed);
                              },
                            ),
                            _buildSelectedButton(
                              iconData: Icons.fact_check,
                              text: "Completed",
                              isSelected:
                                  _userStore.currentSessionFetchStatus ==
                                      SessionStatus.completed,
                              ontap: () {
                                _userStore.updateSessionStatus(
                                    SessionStatus.completed);
                              },
                            ),
                            _buildSelectedButton(
                              iconData: Icons.disabled_visible,
                              text: "Canceled",
                              isSelected:
                                  _userStore.currentSessionFetchStatus ==
                                      SessionStatus.canceled,
                              ontap: () {
                                _userStore.updateSessionStatus(
                                    SessionStatus.canceled);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    Expanded(
                      child: Observer(
                        builder: (_) {
                          if (_userStore.isLoading) {
                            return ListView.builder(
                              padding: const EdgeInsets.only(
                                top: Dimens.large_vertical_padding,
                                right: Dimens.horizontal_padding,
                                left: Dimens.horizontal_padding,
                              ),
                              controller: scrollController,
                              itemBuilder: (_, index) =>
                                  const ListTileItemShimmer(
                                height: 50,
                              ),
                              itemCount: 5,
                            );
                          } else {
                            return ListView.builder(
                              padding: const EdgeInsets.only(
                                top: Dimens.large_vertical_padding,
                                right: Dimens.horizontal_padding,
                                left: Dimens.horizontal_padding,
                              ),
                              controller: scrollController,
                              itemBuilder: (context, index) {
                                Session session =
                                    _userStore.getSessionAt(index);
                                return Container(
                                  margin: const EdgeInsets.only(
                                    bottom: Dimens.medium_vertical_margin,
                                  ),
                                  child: SessionTicketItem(
                                    program: session.program,
                                    statusColor: decideColorOfSession(session),
                                    textColor: Colors.white70,
                                    margin: const EdgeInsets.only(
                                      top: Dimens.vertical_margin,
                                    ),
                                    blur: Properties.blur_glass_morphism,
                                    opacity: Properties.opacity_glass_morphism,
                                    callback: () {
                                      Routes.route(
                                        context,
                                        SesstionDetail(
                                          session: session,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                              itemCount: _userStore.sizeSessionList,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Color decideColorOfSession(Session session) {
    SessionStatus sessionStatus =
        SessionFetchingData.parseSessionStatus(session);

    switch (sessionStatus) {
      case SessionStatus.waiting:
        return Colors.yellow;
      case SessionStatus.confirmed:
        return Colors.green;
      case SessionStatus.completed:
        return Colors.blue;
      case SessionStatus.canceled:
        return Colors.red;
      default:
        return Colors.white;
    }
  }

  Widget _buildMainWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.large_horizontal_padding,
        vertical: Dimens.vertical_padding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: <Widget>[
                  AppIconWidget(
                    dimenImage: Dimens.extra_large_text,
                    image: _themeStore.appIcon,
                  ),
                  Text(
                    DeviceUtils.packageInfo!.appName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.medium_text,
                    ),
                  )
                ],
              ),
              Stack(
                children: [
                  const Icon(
                    Icons.notifications_active_outlined,
                    color: Colors.white,
                    size: Dimens.extra_large_text,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius:
                            BorderRadius.circular(Dimens.kBorderRadiusValue),
                      ),
                      padding: const EdgeInsets.all(1.5),
                      child: const Text(
                        "13+",
                        style: TextStyle(
                          fontSize: Dimens.more_small_text,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(
              bottom: Dimens.large_vertical_margin,
              top: Dimens.extra_large_vertical_margin,
            ),
            child: Text(
              "Your balance",
              style: TextStyle(
                color: Colors.white,
                fontSize: Dimens.lightly_medium_text,
              ),
            ),
          ),
          const Text(
            "\$5000",
            style: TextStyle(
              color: Colors.white,
              fontSize: Dimens.ultra_large_text,
            ),
          ),
          // statices
        ],
      ),
    );
  }

  Widget _buildSelectedButton({
    required IconData iconData,
    required String text,
    required VoidCallback ontap,
    required bool isSelected,
  }) {
    final Color statusColor =
        isSelected ? _themeStore.themeColorfulColor : Colors.white70;

    return SizedBox(
      height: DeviceUtils.getScaledWidth(context, 0.16),
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: GlassmorphismWidgetButton(
          textColor: statusColor,
          radius: 10,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                iconData,
                color: statusColor,
                size: Dimens.large_text,
              ),
              Text(
                text,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          onTap: ontap,
          blur: Properties.blur_glass_morphism,
          opacity: Properties.opacity_glass_morphism,
        ),
      ),
    );
  }
}
