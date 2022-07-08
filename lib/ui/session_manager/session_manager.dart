import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/models/common/session/session.dart';
import 'package:mobile/stores/enum/session_status_enum.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/ui/session_detail/session_detail.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/widgets/glassmorphism_widgets/glassmorphism_widget_button.dart';
import 'package:mobile/widgets/item/session_ticket_item.dart';
import 'package:mobile/widgets/template/glassmorphism_appbar_only.dart';
import 'package:provider/provider.dart';

class SessionManager extends StatefulWidget {
  const SessionManager({Key? key}) : super(key: key);

  @override
  State<SessionManager> createState() => _SessionManagerState();
}

class _SessionManagerState extends State<SessionManager> {
  // store:---------------------------------------------------------------------
  late final UserStore _userStore;

  @override
  void initState() {
    super.initState();

    _userStore = Provider.of<UserStore>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userStore.fetchUserSessions();
  }

  @override
  Widget build(BuildContext context) {
    return GlassmorphismGradientScaffoldAppbar(
      appbarName: AppLocalizations.of(context)
          .translate("session_manager_title_translate"),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: kBottomNavigationBarHeight + Dimens.vertical_margin,
            ),
            Observer(
              builder: (_) {
                return _buildRowControllButtonOnBottomSheet(context);
              },
            ),
            Expanded(
              child: Observer(
                builder: (_) {
                  return ListView.builder(
                    padding: const EdgeInsets.only(
                      top: Dimens.large_vertical_padding,
                      right: Dimens.horizontal_padding,
                      left: Dimens.horizontal_padding,
                    ),
                    itemBuilder: (context, index) {
                      Session? session = _userStore.getSessionAt(index);
                      return _buildSessionItemInBottomSheet(session, context);
                    },
                    itemCount: !_userStore.isSessionLoading
                        ? _userStore.sizeSessionList
                        : 5,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildSessionItemInBottomSheet(
      Session? session, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: Dimens.medium_vertical_margin,
      ),
      child: SessionTicketItem(
        program: session?.program,
        statusColor: decideColorOfSession(session),
        margin: const EdgeInsets.only(
          top: Dimens.vertical_margin,
        ),
        blur: Properties.blur_glass_morphism,
        opacity: Properties.opacity_glass_morphism,
        callbackIfProgramNotNull: () {
          Routes.route(
            context,
            SesstionDetail(
              session: session!,
            ),
          );
        },
      ),
    );
  }

  Color decideColorOfSession(Session? session) {
    if (null == session) {
      return Colors.white;
    }

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

  Row _buildRowControllButtonOnBottomSheet(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildSelectedButton(
          iconData: Icons.clear_all,
          text: AppLocalizations.of(context).translate("all_translate"),
          isSelected: _userStore.currentSessionFetchStatus == SessionStatus.all,
          ontap: () {
            _userStore.updateSessionStatus(SessionStatus.all);
          },
        ),
        _buildSelectedButton(
          iconData: Icons.pending_actions,
          text: AppLocalizations.of(context).translate("waiting_translate"),
          isSelected:
              _userStore.currentSessionFetchStatus == SessionStatus.waiting,
          ontap: () {
            _userStore.updateSessionStatus(SessionStatus.waiting);
          },
        ),
        _buildSelectedButton(
          iconData: Icons.recommend,
          text: AppLocalizations.of(context).translate("confirmed_translate"),
          isSelected:
              _userStore.currentSessionFetchStatus == SessionStatus.confirmed,
          ontap: () {
            _userStore.updateSessionStatus(SessionStatus.confirmed);
          },
        ),
        _buildSelectedButton(
          iconData: Icons.fact_check,
          text: AppLocalizations.of(context).translate("completed_translate"),
          isSelected:
              _userStore.currentSessionFetchStatus == SessionStatus.completed,
          ontap: () {
            _userStore.updateSessionStatus(SessionStatus.completed);
          },
        ),
        _buildSelectedButton(
          iconData: Icons.disabled_visible,
          text: AppLocalizations.of(context).translate("canceled_translate"),
          isSelected:
              _userStore.currentSessionFetchStatus == SessionStatus.canceled,
          ontap: () {
            _userStore.updateSessionStatus(SessionStatus.canceled);
          },
        ),
      ],
    );
  }

  Widget _buildSelectedButton({
    required IconData iconData,
    required String text,
    required VoidCallback ontap,
    required bool isSelected,
  }) {
    final Color statusColor = isSelected
        ? Theme.of(context).highlightColor
        : Color.alphaBlend(
            Theme.of(context).indicatorColor.withOpacity(0.7),
            Colors.white70,
          );

    return SizedBox(
      height: DeviceUtils.getScaledWidth(context, 0.16),
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: GlassmorphismWidgetButton(
          background: statusColor,
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
                textAlign: TextAlign.center,
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
