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
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
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
    _mentorStore.fetchRecommendMentors();

    _userStore = Provider.of<UserStore>(context, listen: false);
    _userStore.fetchFavouriteMentors().then((_) {
      _mentorStore.fetchFavouriteMentors(_userStore.favouriteMentorIdList);
    });

    // build lazy loading in future
    _scrollControllerFavList.addListener(_scrollFavouriteListListener);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        LinearGradientBackground(
          colors: _themeStore.linearGradientColors,
          stops: _themeStore.linearGradientStops,
        ),
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.horizontal_padding,
                vertical: Dimens.vertical_padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Observer(
                  builder: (_) {
                    return Stack(
                      children: <Widget>[
                        Center(
                          heightFactor: 1.5,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)
                                    .translate("greeting"),
                                style: TextStyle(
                                  color: _themeStore.reverseThemeColor,
                                  fontSize: Dimens.lightly_medium_text,
                                ),
                              ),
                              Text(
                                _userStore.user!.name,
                                style: TextStyle(
                                  color: _themeStore.reverseThemeColor,
                                  fontSize: Dimens.large_text,
                                ),
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
                                radius:
                                    DeviceUtils.getScaledHeight(context, 0.04),
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              onTap: () {
                                Routes.navigatorSupporter(
                                    context, Routes.profile);
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // try to lazy loading for favourite mentor
                        Text(
                          AppLocalizations.of(context)
                              .translate("home_favourite_list"),
                          style: TextStyle(
                            color: _themeStore.reverseThemeColor,
                            fontSize: Dimens.lightly_medium_text,
                          ),
                        ),
                        Observer(
                          builder: (_) {
                            return _mentorStore.hasFavouriteMentors
                                ? SizedBox(
                                    height: DeviceUtils.getScaledHeight(
                                        context, 0.3),
                                    child: ListView.builder(
                                      controller: _scrollControllerFavList,
                                      clipBehavior: Clip.none,
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          HomeSuggestMentorItem(
                                        mentorModel:
                                            _mentorStore.favouriteAt(index),
                                        isShowLiked: true,
                                      ),
                                      itemCount: _mentorStore.favouriteLength,
                                    ),
                                  )
                                : const SizedBox();
                          },
                        ),
                        const SizedBox(
                          height: Dimens.large_vertical_margin,
                        ),
                        Text(
                          AppLocalizations.of(context)
                              .translate("home_recommended_list"),
                          style: TextStyle(
                            color: _themeStore.reverseThemeColor,
                            fontSize: Dimens.lightly_medium_text,
                          ),
                        ),
                        Observer(
                          builder: (_) {
                            return _mentorStore.hasRecommendedMentors
                                ? SizedBox(
                                    height: DeviceUtils.getScaledHeight(
                                        context, 0.3),
                                    child: ListView.builder(
                                      clipBehavior: Clip.none,
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          HomeSuggestMentorItem(
                                        mentorModel:
                                            _mentorStore.recommendedAt(index),
                                        isShowLiked: false,
                                      ),
                                      itemCount: _mentorStore.recommendedLength,
                                    ),
                                  )
                                : const SizedBox();
                          },
                        ),
                        const SizedBox(
                          height: kBottomNavigationBarHeight,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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

class HomeSuggestMentorItem extends StatelessWidget {
  HomeSuggestMentorItem({
    Key? key,
    required this.mentorModel,
    required this.isShowLiked,
  }) : super(key: key);

  final MentorModel mentorModel;
  final bool isShowLiked;

  // store:---------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();

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
          GlassmorphismContainer(
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
                  Text(
                    mentorModel.name,
                    style: TextStyle(
                      color: _themeStore.reverseThemeColor,
                      fontSize: Dimens.lightly_medium_text,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: Dimens.vertical_margin,
                  ),
                  Text(
                    "${AppLocalizations.of(context).translate("major_translate")}: ${mentorModel.userMentor.category.name}",
                    style: TextStyle(
                      color: _themeStore.reverseThemeColor,
                      fontSize: Dimens.small_text,
                    ),
                  ),
                ],
              ),
            ),
            blur: Properties.blur_glass_morphism,
            opacity: Properties.opacity_glass_morphism,
          ),
          Positioned(
            top: -25,
            right: -25,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        MentorProfile(idMentor: mentorModel.id),
                  ),
                );
              },
              child: Container(
                width: DeviceUtils.getScaledWidth(context, 0.23),
                height: DeviceUtils.getScaledWidth(context, 0.23),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: _themeStore.reverseThemeColorfulColor,
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                  ],
                  color: _themeStore.reverseThemeColorfulColor,
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
          ),
          isShowLiked
              ? Positioned(
                  left: -5,
                  bottom: 5,
                  child: LikeButton(
                    isLiked: true,
                    size: Dimens.large_text,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    padding: EdgeInsets.zero,
                    likeBuilder: (islike) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.alphaBlend(
                              Colors.red.shade200, Colors.white),
                          boxShadow: [
                            BoxShadow(
                              color: Color.alphaBlend(
                                  Colors.red.shade200, Colors.white),
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
                      // fav mentors
                      return Future.value(!isLiked);
                    },
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

// wait loading: https://flutter.dev/docs/cookbook/effects/shimmer-loading
