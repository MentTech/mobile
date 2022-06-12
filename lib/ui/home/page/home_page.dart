import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/mentor/mentor.dart';
import 'package:mobile/stores/mentor/mentor_store.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/stores/user/user_store.dart';
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
    _userStore.fetchFavouriteMentors();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
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
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: Dimens.lightly_medium_text,
                                ),
                              ),
                              Text(
                                _userStore.user!.name,
                                style: const TextStyle(
                                  color: Colors.white70,
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
                                alternativeUrl:
                                    'https://images.unsplash.com/photo-1648615112483-aeed3ce1385e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=765&q=80',
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
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: Dimens.lightly_medium_text,
                          ),
                        ),
                        SizedBox(
                          height: DeviceUtils.getScaledHeight(context, 0.4),
                          child: Observer(
                            builder: (_) {
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    HomeSuggestMentorItem(
                                  mentorModel: _mentorStore.favouriteAt(index),
                                ),
                                itemCount: _mentorStore.favouriteLength,
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: Dimens.large_vertical_margin,
                        ),
                        Text(
                          AppLocalizations.of(context)
                              .translate("home_recommended_list"),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: Dimens.lightly_medium_text,
                          ),
                        ),
                        SizedBox(
                          height: DeviceUtils.getScaledHeight(context, 0.4),
                          child: Observer(
                            builder: (_) {
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    HomeSuggestMentorItem(
                                  mentorModel:
                                      _mentorStore.recommendedAt(index),
                                ),
                                itemCount: _mentorStore.recommendedLength,
                              );
                            },
                          ),
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
}

class HomeSuggestMentorItem extends StatelessWidget {
  const HomeSuggestMentorItem({
    Key? key,
    required this.mentorModel,
  }) : super(key: key);

  final MentorModel mentorModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GlassmorphismContainer(
          child: Text(
            mentorModel.name,
            style: const TextStyle(color: Colors.white),
          ),
          blur: Properties.blur_glass_morphism,
          opacity: Properties.opacity_glass_morphism,
        ),
      ],
    );
  }
}

// wait loading: https://flutter.dev/docs/cookbook/effects/shimmer-loading
