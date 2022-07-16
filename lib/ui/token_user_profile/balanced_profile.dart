import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/common/session/session.dart';
import 'package:mobile/models/common/transaction/transaction.dart';
import 'package:mobile/stores/enum/session_status_enum.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/widgets/app_icon_widget.dart';
import 'package:mobile/widgets/background_colorful/linear_gradient_background.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:mobile/widgets/item/transaction_ticket_item.dart';
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

  // attribute:-----------------------------------------------------------------
  late double deviceHeight;

  @override
  void initState() {
    super.initState();

    _userStore = Provider.of<UserStore>(context, listen: false);
    _userStore.fetchMyTransactions();
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
            colors: _themeStore.lineToLineGradientColors,
            stops: null,
          ),
          SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildMainWidget(),
                // _buildTransactionArea(),
              ],
            ),
          ),
          _buildDraggableBottomSheet(minChildSize, maxChildSize, context),
        ],
      ),
    );
  }

  // Expanded _buildTransactionArea() {
  //   return Expanded(
  //     child: Observer(
  //       builder: (_) {
  //         return ListView.builder(
  //           padding: const EdgeInsets.only(
  //             top: Dimens.large_vertical_padding,
  //             right: Dimens.horizontal_padding,
  //             left: Dimens.horizontal_padding,
  //           ),
  //           itemBuilder: (_, index) {
  //             Transaction? transaction = _userStore.getTransactionAt(index);
  //             return _buildTransactionItemInBottomSheet(transaction, context);
  //           },
  //           itemCount: !_userStore.isTransactionLoading
  //               ? _userStore.sizeTransactionList
  //               : 5,
  //         );
  //       },
  //     ),
  //   );
  // }

  Container _buildTransactionItemInBottomSheet(
      Transaction? transaction, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: Dimens.medium_vertical_margin,
      ),
      child: TransactionTicketItem(
        transaction: transaction,
        margin: const EdgeInsets.only(
          top: Dimens.vertical_margin,
        ),
        blur: Properties.blur_glass_morphism,
        opacity: Properties.opacity_glass_morphism,
      ),
    );
  }

  DraggableScrollableSheet _buildDraggableBottomSheet(
      double minChildSize, double maxChildSize, BuildContext context) {
    return DraggableScrollableSheet(
      controller: _draggableScrollableController,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      builder: (_, scrollController) {
        return Material(
          elevation: 10,
          color: Color.alphaBlend(
                  Theme.of(context).primaryColor.withOpacity(0.65),
                  Colors.white70)
              .withOpacity(0.65),
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.white10,
            ),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: _buildDraggableBottomSheetContent(context, scrollController),
        );
      },
    );
  }

  Widget _buildDraggableBottomSheetContent(
      BuildContext context, ScrollController scrollController) {
    return GlassmorphismContainer(
      blur: Properties.blur_glass_morphism,
      opacity: Properties.opacity_glass_morphism,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child: SizedBox(
              height: 25,
              child: Center(
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).highlightColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          // Observer(
          //   builder: (_) {
          //     return _buildRowControllButtonOnBottomSheet(context);
          //   },
          // ),
          Expanded(
            child: Observer(
              builder: (_) {
                return ListView.builder(
                  padding: const EdgeInsets.only(
                    top: Dimens.large_vertical_padding,
                    right: Dimens.horizontal_padding,
                    left: Dimens.horizontal_padding,
                  ),
                  itemBuilder: (_, index) {
                    Transaction? transaction =
                        _userStore.getTransactionAt(index);
                    return _buildTransactionItemInBottomSheet(
                      transaction,
                      context,
                    );
                  },
                  itemCount: !_userStore.isTransactionLoading
                      ? _userStore.sizeTransactionList
                      : 5,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Row _buildRowControllButtonOnBottomSheet(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       _buildSelectedButton(
  //         iconData: Icons.clear_all,
  //         text: AppLocalizations.of(context).translate("all_translate"),
  //         isSelected: _userStore.currentSessionFetchStatus == SessionStatus.all,
  //         ontap: () {
  //           _userStore.updateSessionStatus(SessionStatus.all);
  //         },
  //       ),
  //       _buildSelectedButton(
  //         iconData: Icons.pending_actions,
  //         text: AppLocalizations.of(context).translate("waiting_translate"),
  //         isSelected:
  //             _userStore.currentSessionFetchStatus == SessionStatus.waiting,
  //         ontap: () {
  //           _userStore.updateSessionStatus(SessionStatus.waiting);
  //         },
  //       ),
  //       _buildSelectedButton(
  //         iconData: Icons.recommend,
  //         text: AppLocalizations.of(context).translate("confirmed_translate"),
  //         isSelected:
  //             _userStore.currentSessionFetchStatus == SessionStatus.confirmed,
  //         ontap: () {
  //           _userStore.updateSessionStatus(SessionStatus.confirmed);
  //         },
  //       ),
  //       _buildSelectedButton(
  //         iconData: Icons.fact_check,
  //         text: AppLocalizations.of(context).translate("completed_translate"),
  //         isSelected:
  //             _userStore.currentSessionFetchStatus == SessionStatus.completed,
  //         ontap: () {
  //           _userStore.updateSessionStatus(SessionStatus.completed);
  //         },
  //       ),
  //       _buildSelectedButton(
  //         iconData: Icons.disabled_visible,
  //         text: AppLocalizations.of(context).translate("canceled_translate"),
  //         isSelected:
  //             _userStore.currentSessionFetchStatus == SessionStatus.canceled,
  //         ontap: () {
  //           _userStore.updateSessionStatus(SessionStatus.canceled);
  //         },
  //       ),
  //     ],
  //   );
  // }

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

  Widget _buildMainWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.large_horizontal_padding,
        vertical: Dimens.vertical_padding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
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
                  const SizedBox(
                    width: Dimens.large_horizontal_margin,
                  ),
                  Text(
                    DeviceUtils.packageInfo!.appName,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2,
                        ),
                  )
                ],
              ),
              IconButton(
                onPressed: () {
                  Routes.navigatorSupporter(context, Routes.depositToken);
                },
                icon: Icon(
                  Icons.local_atm_rounded,
                  color: Theme.of(context).indicatorColor,
                  size: Dimens.extra_large_text,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: Dimens.large_vertical_margin,
              top: Dimens.extra_large_vertical_margin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)
                      .translate("your_balance_translate"),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.token_rounded,
                      size: Dimens.large_text,
                    ),
                    const SizedBox(
                      width: Dimens.horizontal_margin,
                    ),
                    Observer(builder: (_) {
                      return Text(
                        _userStore.balance.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildSelectedButton({
  //   required IconData iconData,
  //   required String text,
  //   required VoidCallback ontap,
  //   required bool isSelected,
  // }) {
  //   final Color statusColor = isSelected
  //       ? Theme.of(context).highlightColor
  //       : Color.alphaBlend(
  //           Theme.of(context).indicatorColor.withOpacity(0.7),
  //           Colors.white70,
  //         );

  //   return SizedBox(
  //     height: DeviceUtils.getScaledWidth(context, 0.16),
  //     child: AspectRatio(
  //       aspectRatio: 1 / 1,
  //       child: GlassmorphismWidgetButton(
  //         background: statusColor,
  //         radius: 10,
  //         alignment: Alignment.center,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             Icon(
  //               iconData,
  //               color: statusColor,
  //               size: Dimens.large_text,
  //             ),
  //             Text(
  //               text,
  //               textAlign: TextAlign.center,
  //               style: TextStyle(
  //                 color: statusColor,
  //                 fontSize: 10,
  //               ),
  //             ),
  //           ],
  //         ),
  //         onTap: ontap,
  //         blur: Properties.blur_glass_morphism,
  //         opacity: Properties.opacity_glass_morphism,
  //       ),
  //     ),
  //   );
  // }
}
