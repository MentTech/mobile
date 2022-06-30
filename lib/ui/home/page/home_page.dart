import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:like_button/like_button.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/mentor/mentor.dart';
import 'package:mobile/stores/mentor/mentor_store.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/ui/mentor_detail/mentor_profile.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/widgets/background_colorful/linear_gradient_background.dart';
import 'package:mobile/widgets/button_widgets/neumorphism_button.dart';
import 'package:mobile/widgets/container/image_container/network_image_widget.dart';
import 'package:mobile/widgets/container/section_container/wrap_named_list_widget.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:mobile/widgets/glassmorphism_widgets/glassmorphism_widget_button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // controller:----------------------------------------------------------------
  final ScrollController _scrollControllerFavList = ScrollController();

  // store:---------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();

  late final MentorStore _mentorStore;
  late final UserStore _userStore;

  @override
  void initState() {
    super.initState();

    _mentorStore = Provider.of<MentorStore>(context, listen: false);

    _userStore = Provider.of<UserStore>(context, listen: false);
    _userStore.fetchFavouriteMentors(callback: () {
      _mentorStore.fetchFavouriteMentors(_userStore.favouriteMentorIdList);
      _mentorStore.fetchRecommendMentors();
    });

    // build lazy loading in future
    _scrollControllerFavList.addListener(_scrollFavouriteListListener);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LinearGradientBackground(
          colors: _themeStore.lineToLineGradientColors,
          stops: null,
        ),
        SafeArea(
          bottom: false,
          child: _buildHomePageContent(),
        ),
        _buildHomePageHeader(),
      ],
    );
  }

  Observer _buildHomePageHeader() {
    return Observer(
      builder: (_) {
        return Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: GlassmorphismContainer(
            padding:
                const EdgeInsets.symmetric(vertical: Dimens.vertical_padding),
            child: SafeArea(
              bottom: false,
              child: Stack(
                fit: StackFit.passthrough,
                children: <Widget>[
                  Center(
                    heightFactor: 1.5,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context).translate("greeting"),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          _userStore.user!.name,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.horizontal_padding),
                      child: NeumorphismButton(
                        padding: EdgeInsets.zero,
                        child: NetworkImageWidget(
                          url: _userStore.user!.avatar,
                          radius: DeviceUtils.getScaledHeight(context, 0.04),
                          borderRadius: BorderRadius.zero,
                        ),
                        onTap: () {
                          Routes.navigatorSupporter(context, Routes.profile);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            blur: Properties.blur_glass_morphism,
            opacity: Properties.opacity_glass_morphism,
            radius: Dimens.kBorderRadiusValue,
          ),
        );
      },
    );
  }

  Expanded _buildHomePageContent() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimens.horizontal_padding,
            vertical: Dimens.vertical_padding),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                  height: kBottomNavigationBarHeight +
                      Dimens.large_vertical_padding),
              WrapNamedListWidget(
                themeColor: Theme.of(context).indicatorColor,
                namedContainer: AppLocalizations.of(context)
                    .translate("programs_translate"),
                margin: const EdgeInsets.symmetric(
                  vertical: Dimens.large_vertical_margin,
                ),
                children: <Widget>[
                  GlassmorphismWidgetButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconTheme(
                          data: Theme.of(context)
                              .iconTheme
                              .copyWith(size: Dimens.large_text),
                          child: const Icon(
                            Icons.dashboard,
                          ),
                        ),
                        const SizedBox(
                          height: Dimens.vertical_margin,
                        ),
                        Text(
                          AppLocalizations.of(context)
                              .translate("sessions_translate"),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(letterSpacing: 0.2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    width: 100,
                    blur: Properties.blur_glass_morphism,
                    opacity: Properties.opacity_glass_morphism,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.horizontal_padding,
                      vertical: Dimens.vertical_padding,
                    ),
                    radius: 15,
                    onTap: () {
                      // Routes.navigatorSupporter(
                      //   context,
                      //   Routes.tokenProfile,
                      // );
                    },
                  ),
                  GlassmorphismWidgetButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconTheme(
                          data: Theme.of(context)
                              .iconTheme
                              .copyWith(size: Dimens.large_text),
                          child: const Icon(
                            Icons.receipt_long_rounded,
                          ),
                        ),
                        const SizedBox(
                          height: Dimens.vertical_margin,
                        ),
                        Text(
                          AppLocalizations.of(context)
                              .translate("transaction_translate"),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(letterSpacing: 0.2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    width: 100,
                    blur: Properties.blur_glass_morphism,
                    opacity: Properties.opacity_glass_morphism,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.horizontal_padding,
                      vertical: Dimens.vertical_padding,
                    ),
                    radius: 15,
                    onTap: () {
                      Routes.navigatorSupporter(
                        context,
                        Routes.tokenProfile,
                      );
                    },
                  ),
                ],
              ),
              // try to lazy loading for favourite mentor
              Text(
                AppLocalizations.of(context).translate("home_favourite_list"),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).indicatorColor,
                    ),
              ),
              _buildFavouriteContent(),
              const SizedBox(
                height: Dimens.extra_large_vertical_margin,
              ),
              Text(
                AppLocalizations.of(context).translate("home_recommended_list"),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).indicatorColor,
                    ),
              ),
              _buildRecommendedContent(),
              const SizedBox(
                height: kBottomNavigationBarHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Observer _buildRecommendedContent() {
    return Observer(
      builder: (_) {
        return _mentorStore.hasRecommendedMentors
            ? Container(
                height: DeviceUtils.getScaledHeight(context, 0.3),
                margin:
                    const EdgeInsets.only(top: Dimens.large_vertical_margin),
                child: ListView.builder(
                  clipBehavior: Clip.none,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    MentorModel mentorModel = _mentorStore.recommendedAt(index);
                    return HomeMentorItem(
                      mentorModel: mentorModel,
                      isLikedMentor:
                          _userStore.checkIsLikedMentor(mentorModel.id),
                      onCheckFavMentor: (isLiked) {
                        if (_userStore.isPushingFavMentorData) {
                          return Future.value(isLiked);
                        } else {
                          _userStore.callUpdateFavMentor(
                              mentorID: mentorModel.id);
                          return Future.value(!isLiked);
                        }
                      },
                    );
                  },
                  itemCount: _mentorStore.recommendedLength,
                ),
              )
            : const SizedBox();
      },
    );
  }

  Observer _buildFavouriteContent() {
    return Observer(
      builder: (_) {
        return _mentorStore.hasFavouriteMentors
            ? Container(
                height: DeviceUtils.getScaledHeight(context, 0.3),
                margin:
                    const EdgeInsets.only(top: Dimens.large_vertical_margin),
                child: ListView.builder(
                  controller: _scrollControllerFavList,
                  clipBehavior: Clip.none,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    MentorModel mentorModel = _mentorStore.favouriteAt(index);
                    return HomeMentorItem(
                      mentorModel: mentorModel,
                      isLikedMentor:
                          _userStore.checkIsLikedMentor(mentorModel.id),
                      onCheckFavMentor: (isLiked) {
                        if (_userStore.isPushingFavMentorData) {
                          return Future.value(isLiked);
                        } else {
                          _userStore.callUpdateFavMentor(
                              mentorID: mentorModel.id);
                          return Future.value(!isLiked);
                        }
                      },
                    );
                  },
                  itemCount: _mentorStore.favouriteLength,
                ),
              )
            : const SizedBox();
      },
    );
  }

  void _scrollFavouriteListListener() {
    log("messenger: ${_scrollControllerFavList.position.extentAfter}");
    // if (controller.position.extentAfter < 500) {
    //   setState(() {
    //     items.addAll(List.generate(42, (index) => 'Inserted $index'));
    //   });
    // }
  }
}

class HomeMentorItem extends StatelessWidget {
  const HomeMentorItem({
    Key? key,
    required this.mentorModel,
    required this.onCheckFavMentor,
    required this.isLikedMentor,
  }) : super(key: key);

  final MentorModel mentorModel;
  final bool isLikedMentor;

  final Future<bool> Function(bool) onCheckFavMentor;

  // store:---------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: Dimens.extra_large_horizontal_margin,
        top: Dimens.ultra_extra_large_vertical_margin,
        right: Dimens.extra_large_horizontal_margin,
        bottom: Dimens.extra_large_vertical_margin,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _buildContent(context),
          _buildAvatar(context),
          _buildFavButton(),
        ],
      ),
    );
  }

  Positioned _buildFavButton() {
    return Positioned(
      top: 15,
      right: 15,
      child: LikeButton(
        isLiked: isLikedMentor,
        size: Dimens.large_text,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        padding: EdgeInsets.zero,
        likeBuilder: (islike) {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.alphaBlend(Colors.red.shade200, Colors.white),
              boxShadow: [
                BoxShadow(
                  color: Color.alphaBlend(Colors.red.shade200, Colors.white),
                  blurRadius: 3,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Icon(
              Icons.favorite,
              size: Dimens.medium_text,
              color: islike ? Colors.red.shade400 : Colors.white54,
            ),
          );
        },
        onTap: (isLiked) {
          return onCheckFavMentor(isLiked);
        },
      ),
    );
  }

  Positioned _buildAvatar(BuildContext context) {
    return Positioned(
      top: -25,
      left: -15,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MentorProfile(idMentor: mentorModel.id),
            ),
          );
        },
        child: Container(
          width: DeviceUtils.getScaledWidth(context, 0.23),
          height: DeviceUtils.getScaledWidth(context, 0.23),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).highlightColor,
                blurRadius: 12,
                spreadRadius: 1,
              ),
            ],
            color: Theme.of(context).highlightColor,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(3), // border width
            child: ClipOval(
              child: NetworkImageWidget(url: mentorModel.avatar),
            ),
          ),
        ),
      ),
    );
  }

  GlassmorphismContainer _buildContent(BuildContext context) {
    return GlassmorphismContainer(
      height: DeviceUtils.getScaledWidth(context, 0.45),
      width: DeviceUtils.getScaledWidth(context, 0.45),
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.horizontal_padding,
        vertical: Dimens.vertical_padding,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: DeviceUtils.getScaledWidth(context, 0.15),
            ),
            InkWell(
              child: Text(
                mentorModel.name,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        MentorProfile(idMentor: mentorModel.id),
                  ),
                );
              },
            ),
            const SizedBox(
              height: Dimens.vertical_margin,
            ),
            Text(
              "${AppLocalizations.of(context).translate("major_translate")}: ${mentorModel.userMentor.category.name}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      blur: Properties.blur_glass_morphism,
      opacity: Properties.opacity_glass_morphism,
    );
  }
}
