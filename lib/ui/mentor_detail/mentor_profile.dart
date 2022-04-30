import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:mobile/constants/colors.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/common/degree/degree.dart';
import 'package:mobile/models/common/experience/experience.dart';
import 'package:mobile/models/common/program/program.dart';
import 'package:mobile/models/common/skill/skill.dart';
import 'package:mobile/models/mentor/mentor.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/widgets/background_colorful/random_bubble_gradient_background.dart';
import 'package:mobile/widgets/button_widgets/neumorphism_button.dart';
import 'package:mobile/widgets/common_model_widgets/skill_widget.dart';
import 'package:mobile/widgets/container/image_container/network_image_widget.dart';
import 'package:mobile/widgets/container/section_container/description_title_container.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:mobile/widgets/item/session_ticket_item.dart';
import 'package:readmore/readmore.dart';

class MentorProfile extends StatefulWidget {
  const MentorProfile({
    Key? key,
    required this.mentorModel,
  }) : super(key: key);

  final MentorModel mentorModel;

  @override
  _MentorProfileState createState() => _MentorProfileState();
}

class _MentorProfileState extends State<MentorProfile> {
  // Controller:----------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          RandomBubbleGradientBackground(
            count: 8,
            maxRadius: 100,
            minRadius: 50,
            gradientColor: const [Colors.orange, Colors.green],
          ),
          CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              SliverPersistentHeader(
                delegate: MentorProfileSliverAppbarDelegate(
                  expandedHeight: DeviceUtils.getScaledHeight(context, .65),
                  mentorModel: widget.mentorModel,
                ),
                floating: false,
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: _buildContentLayout(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContentLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        DescriptionTitleContainer(
          titleWidget: const Text(
            "Introduction: ",
            style: TextStyle(
              fontSize: Dimens.lightly_medium_text,
            ),
          ),
          contentWidget: ReadMoreText(
            widget.mentorModel.userMentor.introduction,
            style: const TextStyle(
              fontSize: Dimens.small_text,
            ),
            trimLines: 5,
            trimLength: 300,
          ),
          spaceBetween: Dimens.vertical_margin * 2,
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.horizontal_padding,
            vertical: Dimens.large_vertical_margin,
          ),
        ),
        DescriptionTitleContainer(
          titleWidget: const Text(
            "Program: ",
            style: TextStyle(
              fontSize: Dimens.lightly_medium_text,
            ),
          ),
          contentWidget: Column(
            children: [
              for (Program program in widget.mentorModel.userMentor.programs)
                SessionTicketItem(
                  program: program,
                  margin: const EdgeInsets.only(
                    top: Dimens.vertical_margin,
                  ),
                ),
            ],
          ),
          spaceBetween: Dimens.vertical_margin,
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.horizontal_padding,
            vertical: Dimens.large_vertical_margin,
          ),
        ),
        DescriptionTitleContainer(
          titleWidget: const Text(
            "Skill: ",
            style: TextStyle(
              fontSize: Dimens.lightly_medium_text,
            ),
          ),
          contentWidget: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(
                  width: Dimens.large_horizontal_margin,
                ),
                for (Skill skill in widget.mentorModel.userMentor.skills)
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
        ),
        DescriptionTitleContainer(
          titleWidget: const Text(
            "Degree: ",
            style: TextStyle(
              fontSize: Dimens.lightly_medium_text,
            ),
          ),
          contentWidget: Column(
            children: [
              for (Degree degree in widget.mentorModel.userMentor.degree)
                SymbolsItem(
                  symbol: const Icon(
                    Icons.arrow_right_rounded,
                    size: Dimens.large_text,
                  ),
                  child: Text(
                    degree.title,
                    style: const TextStyle(
                      fontSize: Dimens.small_text,
                    ),
                  ),
                )
            ],
          ),
          spaceBetween: Dimens.vertical_margin * 2,
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.horizontal_padding,
            vertical: Dimens.large_vertical_margin,
          ),
        ),
        DescriptionTitleContainer(
          titleWidget: const Text(
            "Experience: ",
            style: TextStyle(
              fontSize: Dimens.lightly_medium_text,
            ),
          ),
          contentWidget: Column(
            children: [
              for (Experience experience
                  in widget.mentorModel.userMentor.experiences)
                SymbolsItem(
                  symbol: const Icon(
                    Icons.arrow_right_rounded,
                    size: Dimens.large_text,
                  ),
                  child: Text(
                    experience.title ?? "Unknown",
                    style: const TextStyle(
                      fontSize: Dimens.small_text,
                    ),
                  ),
                )
            ],
          ),
          spaceBetween: Dimens.vertical_margin * 2,
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.horizontal_padding,
            vertical: Dimens.large_vertical_margin,
          ),
        ),
      ],
    );
  }
}

class MentorProfileSliverAppbarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final MentorModel mentorModel;

  final ThemeStore _themeStore = getIt<ThemeStore>();

  MentorProfileSliverAppbarDelegate({
    required this.expandedHeight,
    required this.mentorModel,
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
                  style: TextStyle(
                    color: _themeStore.textTitleColor,
                    fontSize: Dimens.medium_text,
                  ),
                ),
                Text(
                  "Age: ${mentorModel.age}",
                  style: TextStyle(
                    color: _themeStore.textTitleColor,
                    fontSize: Dimens.small_text,
                  ),
                ),
                Text(
                  "Major: ${mentorModel.userMentor.category.name}",
                  style: TextStyle(
                    color: _themeStore.textTitleColor,
                    fontSize: Dimens.small_text,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star_rate_rounded,
                          color: _themeStore.ratingColor,
                          size: Dimens.medium_text,
                        ),
                        Text(
                          " ${mentorModel.userMentor.rating}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: Dimens.small_text),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.horizontal_margin,
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: FaIcon(
                              FontAwesomeIcons.linkedinIn,
                              color: _themeStore.themeColor,
                              size: Dimens.small_text,
                            ),
                            onPressed: () {
                              // log(mentorModel.userMentor.linkedin ?? "No Linkedin");
                            },
                          ),
                        ),
                        const SizedBox(
                          width: Dimens.horizontal_margin,
                        ),
                      ],
                    ),
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
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.horizontal_padding,
        ),
        child:
            // Align(
            //   child: LikeButton(
            //     size: Dimens.extra_large_text,
            //     onTap: (bool isCheck) {
            //       return Future.value(!isCheck);
            //     },
            //   ),
            // ),

            Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
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
