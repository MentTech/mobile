import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/constants/colors.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/user/user.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/ui/user_profile/user_editable_popup.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/widgets/background_colorful/linear_gradient_background.dart';
import 'package:mobile/widgets/background_colorful/random_bubble_gradient_background.dart';
import 'package:mobile/widgets/button_widgets/neumorphism_button.dart';
import 'package:mobile/widgets/container/image_container/network_image_widget.dart';
import 'package:mobile/widgets/container/section_container/description_title_container.dart';
import 'package:mobile/widgets/dialog_showing/slider_dialog.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late UserStore userStore;

  // Controller:----------------------------------------------------------------
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  int curPage = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    userStore = Provider.of<UserStore>(context);
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const LinearGradientBackground(),
          RandomBubbleGradientBackground(
            count: 3,
            maxRadius: 150,
            minRadius: 50,
            gradientColor: [
              AppColors.lightBlueContrast.withOpacity(0.1),
              AppColors.darkBlueContrast,
            ],
          ),
          CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: CustomSliverAppbarDelegate(
                  expandedHeight: DeviceUtils.getScaledHeight(context, .65),
                  userModel: userStore.user!,
                ),
                floating: true,
                pinned: true,
              ),
              SliverFillRemaining(
                child: Consumer<UserStore>(
                  builder: (BuildContext context, UserStore authenInfor,
                      Widget? child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: Dimens.vertical_margin * 3,
                        ),
                        authenInfor.user != null &&
                                authenInfor.user!.birthday != null
                            ? DescriptionTitleContainer(
                                titleWidget: const Text("Birthday"),
                                contentWidget: Text(DateFormat("")
                                    .format(authenInfor.user!.birthday!)),
                                spaceBetween: Dimens.vertical_margin * 2,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimens.horizontal_padding),
                              )
                            : const SizedBox(),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomSliverAppbarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final UserModel userModel;

  CustomSliverAppbarDelegate({
    required this.expandedHeight,
    required this.userModel,
  });

  double shrinkPerExpanded(double shrinkOffset) =>
      shrinkOffset / expandedHeight;
  double inverseShrinkPerExpanded(double shrinkOffset) =>
      1 - shrinkOffset / expandedHeight;

  Widget buildUserMainContent() =>
      Consumer<UserStore>(builder: (context, authenInfor, child) {
        ThemeStore themeStore = getIt<ThemeStore>();

        return GlassmorphismContainer(
          blur: Properties.blur_glass_morphism,
          opacity: Properties.opacity_glass_morphism,
          padding: const EdgeInsets.symmetric(
            vertical: Dimens.vertical_padding,
            horizontal: Dimens.horizontal_padding,
          ),
          height: kToolbarHeight * 3,
          width: DeviceUtils.getScaledWidth(context, 1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    authenInfor.user?.name ?? "",
                    style: TextStyle(
                      color: themeStore.textTitleColor,
                      fontSize: Dimens.medium_text,
                    ),
                  ),
                  Text(
                    authenInfor.user?.email ?? "",
                    style: TextStyle(
                      color: themeStore.textTitleColor,
                      fontSize: Dimens.small_text,
                    ),
                  ),
                  Text(
                    "Token: ${authenInfor.user?.coin ?? 0}",
                    style: TextStyle(
                      color: themeStore.textTitleColor,
                      fontSize: Dimens.small_text,
                    ),
                  ),
                ],
              ),
              NetworkImageWidget(url: userModel.avatar),
            ],
          ),
        );
      });

  Widget buildBackground() => ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
              opacity: 0.3,
              child: CachedNetworkImage(
                imageUrl:
                    "https://images.unsplash.com/photo-1649217708305-685a96a98279?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8",
                fit: BoxFit.fill,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (BuildContext context, String url, dynamic error) {
                  if (error.statusCode == 403) {
                    // Code to handle 403 error corrections on the database.
                    // Not implemented when experiencing this issue.
                  } else if (error.statusCode == 404) {
                    // log("File Not Found");
                  }
                  return const Icon(Icons.error_outline);
                },
              ),
            ),
            Center(
              child: CachedNetworkImage(
                imageUrl:
                    "https://images.unsplash.com/photo-1649217708305-685a96a98279?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8",
                fit: BoxFit.fitHeight,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (BuildContext context, String url, dynamic error) {
                  if (error.statusCode == 403) {
                    // Code to handle 403 error corrections on the database.
                    // Not implemented when experiencing this issue.
                  } else if (error.statusCode == 404) {
                    // log("File Not Found");
                  }
                  return const Icon(Icons.error_outline);
                },
              ),
            ),
          ],
        ),
      );

  Widget buildControlButton(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Go back button
            NeumorphismButton(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.darkBlue[700],
              ),
              onTap: () {
                Routes.popRoute(context);
              },
            ),
            // Edit information popup
            NeumorphismButton(
              child: Icon(
                Icons.edit,
                color: AppColors.darkBlue[700],
              ),
              shape: BoxShape.circle,
              onTap: () {
                DialogPopupPresenter.showSlidePopupDialog<bool>(
                        context,
                        const UserEditablePopup(),
                        DeviceUtils.getScaledHeight(context, 0.8),
                        DeviceUtils.getScaledWidth(context, 0.8))
                    .then((bool? result) {
                  //
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        buildBackground(),
        Positioned(
          bottom: 0,
          child: buildUserMainContent(),
        ),
        buildControlButton(context),
        // buildContent(shrinkOffset, context),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight * 5;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return this != oldDelegate;
  }
}
