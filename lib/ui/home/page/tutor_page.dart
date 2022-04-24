import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/constants/colors.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/mentor/mentor.dart';
import 'package:mobile/stores/mentor/mentor_store.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/ui/mentor_detail/mentor_profile.dart';
import 'package:mobile/utils/application/application_utils.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/button_widgets/neumorphism_button.dart';
import 'package:mobile/widgets/container/image_container/network_image_widget.dart';
import 'package:mobile/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TutorPage extends StatefulWidget {
  const TutorPage({Key? key}) : super(key: key);

  @override
  _TutorPageState createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
  // controller:----------------------------------------------------------------
  final TextEditingController _searchController = TextEditingController();

  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  // store:---------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();
  late MentorStore _mentorStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _mentorStore = Provider.of<MentorStore>(context);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => DeviceUtils.hideKeyboard(context),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimens.horizontal_padding,
              vertical: Dimens.vertical_padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.horizontal_padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Go back button
                    NeumorphismButton(
                      child: Icon(
                        Icons.category_outlined,
                        color: AppColors.darkBlue[700],
                      ),
                      onTap: () {
                        //
                      },
                    ),
                    // Edit information popup
                    Observer(
                      builder: (context) {
                        final UserStore userStore =
                            Provider.of<UserStore>(context, listen: false);
                        return NeumorphismButton(
                          padding: EdgeInsets.zero,
                          child: NetworkImageWidget(
                            url: userStore.user!.avatar,
                            alternativeUrl:
                                'https://images.unsplash.com/photo-1648615112483-aeed3ce1385e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=765&q=80',
                            radius: DeviceUtils.getScaledHeight(context, 0.03),
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          onTap: () {
                            //
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              TextFieldWidget(
                isObscure: false,
                padding: const EdgeInsets.only(top: 16.0),
                textController: _searchController,
                textStyle: const TextStyle(fontSize: Dimens.small_text),
                inputDecoration: InputDecoration(
                    hintText:
                        AppLocalizations.of(context).translate('mentor_search'),
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: _themeStore.textTitleColor),
                    counterText: '',
                    icon: Icon(Icons.search_rounded,
                        color: _themeStore.textTitleColor)),
                onChanged: (value) {},
                onFieldSubmitted: (value) {
                  // log("submit");
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: Dimens.vertical_space),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FilterButtonTag(
                        text: "Category",
                        isFilted: true,
                      ),
                      FilterButtonTag(
                        text: "Skill",
                        isFilted: false,
                      ),
                      FilterButtonTag(
                        text: "OrderBy",
                        isFilted: true,
                      ),
                      FilterButtonTag(
                        text: "Sort",
                        isFilted: false,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Observer(
                  builder: (_) {
                    return ClipRRect(
                      borderRadius:
                          BorderRadius.circular(Dimens.kBorderMaxRadiusValue),
                      child: SmartRefresher(
                        controller: _refreshController,
                        enablePullUp: true,
                        enablePullDown: true,
                        header: ApplicationUtils.fetchHeaderStatus(context),
                        footer: ApplicationUtils.fetchFooterStatus(),
                        onRefresh: () async {
                          if (_mentorStore.prevPage()) {
                            _mentorStore.callback =
                                () => _refreshController.refreshCompleted();

                            await _mentorStore.searchMentors().then((_) {
                              // if (tutorStore.isSearch) {
                              //   DeviceUtils.showSnackBar(
                              //       context,
                              //       AppLocalizations.of(context)
                              //           .translate("search_tutor_results")
                              //           .format([
                              //         tutorStore.countTutors.toString()
                              //       ]));
                              // }
                            });
                          } else {
                            _refreshController.refreshCompleted();
                          }
                        },
                        onLoading: () async {
                          if (_mentorStore.nextPage()) {
                            await _mentorStore.searchMentors().then((_) {
                              //

                              _refreshController.loadComplete();
                            });
                          } else {
                            _refreshController.loadComplete();
                          }
                        },
                        child: Wrap(
                          alignment: WrapAlignment.spaceAround,
                          spacing: Dimens.vertical_space,
                          runSpacing: Dimens.horizontal_space,
                          direction: Axis.horizontal,
                          children: List.generate(_mentorStore.length, (i) => i)
                              .map(
                                (i) => ShortImformationItem(
                                    mentorModel: _mentorStore.at(i),
                                    onTapViewDetail: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => MentorProfile(
                                            mentorModel: _mentorStore.at(i)),
                                      ));
                                    }),
                              )
                              .toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterButtonTag extends StatelessWidget {
  FilterButtonTag({
    Key? key,
    required this.text,
    required this.isFilted,
  }) : super(key: key);

  final String text;
  final bool isFilted;

  //store:----------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: DeviceUtils.getScaledWidth(context, 0.25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: Dimens.small_text,
                  color: isFilted
                      ? _themeStore.textChoosed
                      : _themeStore.textNotChoosed),
            ),
            const SizedBox(
              height: Dimens.vertical_margin,
            ),
            Icon(
              Icons.fiber_manual_record,
              color: isFilted
                  ? _themeStore.textChoosed
                  : _themeStore.textNotChoosed,
              size: Dimens.small_text,
            ),
          ],
        ),
      ),
    );
  }
}

class ShortImformationItem extends StatelessWidget {
  ShortImformationItem({
    Key? key,
    required this.mentorModel,
    required this.onTapViewDetail,
  }) : super(key: key);

  final MentorModel mentorModel;
  final VoidCallback onTapViewDetail;

  final ThemeStore _themeStore = getIt<ThemeStore>();

  final double height = 200;
  final double width = 165;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.kBorderMaxRadiusValue),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _themeStore.firstGradientColor,
            _themeStore.secondGradientColor,
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: width * 0.05, horizontal: width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: Dimens.kMaxBorderRadius,
              child: Stack(
                children: <Widget>[
                  NetworkImageWidget(
                    url: null, //mentorModel.avatar,
                    radius: width * 0.45,
                    borderRadius: BorderRadius.circular(0.0),
                    alternativeUrl:
                        'https://images.unsplash.com/photo-1648615112483-aeed3ce1385e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=765&q=80',
                    onTap: onTapViewDetail,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100.withOpacity(0.25),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(
                                    Dimens.kBorderUltraRadiusValue))),
                        padding: const EdgeInsets.only(
                          top: Dimens.small_vertical_padding,
                          bottom: Dimens.small_vertical_padding,
                          left: Dimens.large_horizontal_padding,
                          right: Dimens.horizontal_padding,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.star_rate_rounded,
                              color: _themeStore.ratingColor,
                              size: Dimens.medium_text,
                            ),
                            Text(
                              " ${mentorModel.userMentor.rating}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimens.small_text),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
              child: InkWell(
                borderRadius: Dimens.kMaxBorderRadius,
                onTap: onTapViewDetail,
                child: Text(
                  mentorModel.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: Dimens.lightly_medium_text),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
              child: Text(
                mentorModel.userMentor.introduction,
                style: const TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
              child: Text(
                "Major: ${mentorModel.userMentor.category.name}",
                style: const TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
            mentorModel.userMentor.linkedin != null
                ? Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: Dimens.small_vertical_padding,
                            horizontal: Dimens.small_horizontal_padding),
                        constraints: const BoxConstraints(),
                        icon: FaIcon(
                          FontAwesomeIcons.linkedinIn,
                          color: _themeStore.themeColor,
                          size: Dimens.small_text,
                        ),
                        onPressed: () {
                          log(mentorModel.userMentor.linkedin ?? "No Linkedin");
                        }),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
