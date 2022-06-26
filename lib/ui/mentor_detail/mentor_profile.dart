import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:like_button/like_button.dart';
import 'package:mobile/constants/assets.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/common/achievement/achievement.dart';
import 'package:mobile/models/common/degree/degree.dart';
import 'package:mobile/models/common/experience/experience.dart';
import 'package:mobile/models/common/program/program.dart';
import 'package:mobile/models/common/skill/skill.dart';
import 'package:mobile/models/mentor/mentor.dart';
import 'package:mobile/stores/mentor/mentor_store.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/widgets/background_colorful/linear_gradient_background.dart';
import 'package:mobile/widgets/button_widgets/neumorphism_button.dart';
import 'package:mobile/widgets/common_model_widgets/achievement_widget.dart';
import 'package:mobile/widgets/common_model_widgets/experience_widget.dart';
import 'package:mobile/widgets/common_model_widgets/skill_widget.dart';
import 'package:mobile/widgets/container/image_container/network_image_widget.dart';
import 'package:mobile/widgets/container/section_container/description_title_container.dart';
import 'package:mobile/widgets/errors_widget/text_error.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:mobile/widgets/item/session_ticket_item.dart';
import 'package:mobile/widgets/shimmer_loading_effect/profile_shimmer_loading_effect.dart';
import 'package:mobile/widgets/star_widget/start_rate_widget.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class MentorProfile extends StatefulWidget {
  const MentorProfile({
    Key? key,
    required this.idMentor,
  }) : super(key: key);

  final int idMentor;

  @override
  _MentorProfileState createState() => _MentorProfileState();
}

class _MentorProfileState extends State<MentorProfile> {
  // Store:---------------------------------------------------------------------
  late final MentorStore _mentorStore;
  late final UserStore _userStore;
  final ThemeStore _themeStore = getIt<ThemeStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _mentorStore = Provider.of<MentorStore>(context, listen: false);
    _mentorStore.fetchAMentor(widget.idMentor);

    _userStore = Provider.of<UserStore>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();

    _mentorStore.clearCurrentMentor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LinearGradientBackground(
            colors: _themeStore.lineToLineGradientColors,
            stops: null,
          ),
          Observer(
            builder: (BuildContext context) {
              if (_mentorStore.isLoading) {
                return ProfileShimmerLoadingEffect();
              } else {
                if (_mentorStore.hasMentor) {
                  return CustomScrollView(
                    scrollDirection: Axis.vertical,
                    slivers: [
                      SliverPersistentHeader(
                        delegate: MentorProfileSliverAppbarDelegate(
                            expandedHeight:
                                DeviceUtils.getScaledHeight(context, .65),
                            mentorModel: _mentorStore.getMentor!,
                            isLikedMentor: _userStore.checkIsLikedMentor(
                                _mentorStore.mentorModel!.id),
                            onLikedMentor: (isLiked) {
                              if (_userStore.isPushingFavMentorData) {
                                return Future.value(isLiked);
                              } else {
                                _userStore.callUpdateFavMentor(
                                    mentorID: _mentorStore.mentorModel!.id);
                                return Future.value(!isLiked);
                              }
                            }),
                        floating: true,
                        pinned: true,
                      ),
                      SliverToBoxAdapter(
                        child: _buildContentLayout(_mentorStore.getMentor!),
                      ),
                    ],
                  );
                } else {
                  return const TextShowingError();
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContentLayout(MentorModel mentorModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIntroductionSection(mentorModel.userMentor),
        _buildProgramSection(mentorModel.userMentor.programs ?? []),
        _buildSkillSection(mentorModel.userMentor.skills),
        _buildDegreeSection(mentorModel.userMentor.degrees),
        _buildExperienceSection(mentorModel.userMentor.experiences),
        _buildAchievementSection(mentorModel.userMentor.achievements),
        const SizedBox(
          height: kBottomNavigationBarHeight,
        ),
      ],
    );
  }

  DescriptionTitleContainer _buildIntroductionSection(UserMentor userMentor) {
    return DescriptionTitleContainer(
      titleWidget: Text(
        "${AppLocalizations.of(context).translate("introduction_translate")}: ",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      contentWidget: ReadMoreText(
        userMentor.introduction ?? "",
        style: Theme.of(context).textTheme.bodySmall,
        trimLines: 5,
        trimLength: 300,
      ),
      spaceBetween: Dimens.medium_vertical_margin,
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.horizontal_padding,
        vertical: Dimens.large_vertical_margin,
      ),
    );
  }

  DescriptionTitleContainer _buildProgramSection(List<Program> programs) {
    return DescriptionTitleContainer(
      titleWidget: Text(
        "${AppLocalizations.of(context).translate("program_translate")}: ",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      contentWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (Program program in programs)
            SessionTicketItem(
              program: program,
              margin: const EdgeInsets.only(
                top: Dimens.vertical_margin,
              ),
              callbackIfProgramNotNull: () {
                _mentorStore.fetchProgramOfMentor(program.id).then((_) {
                  Routes.navigatorSupporter(context, Routes.programRegister);
                });
              },
            ),
        ],
      ),
      spaceBetween: Dimens.vertical_margin,
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.horizontal_padding,
        vertical: Dimens.large_vertical_margin,
      ),
    );
  }

  DescriptionTitleContainer _buildSkillSection(List<Skill> skills) {
    return DescriptionTitleContainer(
      titleWidget: Text(
        "${AppLocalizations.of(context).translate("skill_translate")}: ",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      contentWidget: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const SizedBox(
              width: Dimens.large_horizontal_margin,
            ),
            for (Skill skill in skills)
              SkillWidgetContainer(
                width: 130,
                skill: skill,
                padding: const EdgeInsets.symmetric(
                  vertical: Dimens.small_vertical_padding,
                ),
                margin: const EdgeInsets.symmetric(
                    horizontal: Dimens.medium_horizontal_margin),
              ),
            const SizedBox(
              width: Dimens.large_horizontal_margin,
            ),
          ],
        ),
      ),
      spaceBetween: Dimens.vertical_margin * 2,
      padding: const EdgeInsets.symmetric(
        vertical: Dimens.large_vertical_margin,
      ),
      paddingTitle: const EdgeInsets.symmetric(
        horizontal: Dimens.horizontal_padding,
      ),
    );
  }

  DescriptionTitleContainer _buildDegreeSection(List<Degree> degrees) {
    return DescriptionTitleContainer(
      titleWidget: Text(
        "${AppLocalizations.of(context).translate("degree_translate")}: ",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      contentWidget: Column(
        children: [
          for (Degree degree in degrees)
            SymbolsItem(
              symbol: const Icon(
                Icons.arrow_right_rounded,
                size: Dimens.large_text,
              ),
              child: Text(
                degree.title,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )
        ],
      ),
      spaceBetween: Dimens.vertical_margin * 2,
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.horizontal_padding,
        vertical: Dimens.large_vertical_margin,
      ),
    );
  }

  DescriptionTitleContainer _buildExperienceSection(
      List<Experience> experiences) {
    return DescriptionTitleContainer(
      titleWidget: Text(
        "${AppLocalizations.of(context).translate("experience_translate")}: ",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      contentWidget: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (Experience experience in experiences)
            ExperienceWidget(
              experience: experience,
              margin:
                  const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
            ),
        ],
      ),
      spaceBetween: Dimens.vertical_margin * 2,
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.horizontal_padding,
        vertical: Dimens.large_vertical_margin,
      ),
    );
  }

  DescriptionTitleContainer _buildAchievementSection(
      List<Achievement> achievements) {
    return DescriptionTitleContainer(
      titleWidget: Text(
        "${AppLocalizations.of(context).translate("achievement_translate")}: ",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      contentWidget: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (Achievement achievement in achievements)
            AchievementWidget(
              achievement: achievement,
              margin:
                  const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
            ),
        ],
      ),
      spaceBetween: Dimens.vertical_margin * 2,
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.horizontal_padding,
        vertical: Dimens.large_vertical_margin,
      ),
    );
  }
}

class MentorProfileSliverAppbarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final MentorModel mentorModel;
  final bool isLikedMentor;

  final Future<bool> Function(bool)? onLikedMentor;

  MentorProfileSliverAppbarDelegate({
    required this.expandedHeight,
    required this.mentorModel,
    required this.isLikedMentor,
    this.onLikedMentor,
  });

  double shrinkPerExpanded(double shrinkOffset) =>
      shrinkOffset / expandedHeight;
  double inverseShrinkPerExpanded(double shrinkOffset) =>
      1 - shrinkOffset / expandedHeight;

  Widget buildUserMainContent(BuildContext context) {
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
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  mentorModel.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "${AppLocalizations.of(context).translate("age_translate")}: ${mentorModel.age}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  "${AppLocalizations.of(context).translate("major_translate")}: ${mentorModel.userMentor.category.name}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StarRateWidget(
                      rateColor: Theme.of(context).selectedRowColor,
                      rating: mentorModel.userMentor.rating ?? 0.0,
                    ),
                    // Row(
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //         horizontal: Dimens.horizontal_margin,
                    //       ),
                    //       child: IconButton(
                    //         padding: EdgeInsets.zero,
                    //         constraints: const BoxConstraints(),
                    //         icon: FaIcon(
                    //           FontAwesomeIcons.linkedinIn,
                    //           color: Theme.of(context).indicatorColor,
                    //           size: Dimens.small_text,
                    //         ),
                    //         onPressed: () {
                    //           // log(mentorModel.userMentor.linkedin ?? "No Linkedin");
                    //         },
                    //       ),
                    //     ),
                    //     const SizedBox(
                    //       width: Dimens.horizontal_margin,
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ],
            ),
          ),
          NetworkImageWidget(
            url: mentorModel.avatar,
          ),
        ],
      ),
    );
  }

  Widget buildBackground() => ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
              opacity: 0.3,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      Assets.settingsBackgroundAssets,
                    ),
                    fit: BoxFit.fitHeight,
                    opacity: Properties.opacity_mode,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      Assets.settingsBackgroundAssets,
                    ),
                    fit: BoxFit.fitHeight,
                    opacity: Properties.opacity_mode,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildControlButton(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.horizontal_padding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Go back button
            NeumorphismButton(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                Routes.popRoute(context);
              },
            ),
            SizedBox(
              height: Dimens.ultra_large_text,
              child: LikeButton(
                isLiked: isLikedMentor,
                size: Dimens.extra_large_text,
                likeBuilder: (islike) {
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          Color.alphaBlend(Colors.red.shade200, Colors.white),
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
                onTap: (bool isLiked) {
                  return onLikedMentor?.call(isLiked) ?? Future.value(isLiked);
                },
              ),
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
      alignment: Alignment.topCenter,
      children: <Widget>[
        buildBackground(),
        Positioned(
          bottom: 0,
          child: buildUserMainContent(context),
        ),
        buildControlButton(context),
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

class FadingEffect extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromPoints(Offset.zero, Offset(size.width, size.height));
    LinearGradient lg = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          //create 2 white colors, one transparent
          Color.fromARGB(255, 255, 255, 255),
          Color.fromARGB(0, 255, 255, 255),
        ]);
    Paint paint = Paint()..shader = lg.createShader(rect);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(FadingEffect oldDelegate) => false;
}

class SymbolsItem extends StatelessWidget {
  const SymbolsItem({
    Key? key,
    required this.symbol,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.spacing = 0,
  }) : super(key: key);

  final EdgeInsets padding;
  final double spacing;

  final Widget symbol;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          symbol,
          SizedBox(
            width: spacing,
          ),
          child,
        ],
      ),
    );
  }
}
