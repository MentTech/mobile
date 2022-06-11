import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/mentor/mentor.dart';
import 'package:mobile/stores/common/common_store.dart';
import 'package:mobile/stores/mentor/mentor_store.dart';
import 'package:mobile/stores/search_store.dart/search_store.dart';
import 'package:mobile/stores/search_store.dart/search_type_enum.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/ui/mentor_detail/mentor_profile.dart';
import 'package:mobile/utils/application/application_utils.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/widgets/background_colorful/linear_gradient_background.dart';
import 'package:mobile/widgets/button_widgets/neumorphism_button.dart';
import 'package:mobile/widgets/container/image_container/network_image_widget.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:mobile/widgets/popup_template/hero_popup_routes.dart';
import 'package:mobile/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:readmore/readmore.dart';

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

  late final MentorStore _mentorStore;
  late final CommonStore _commonStore;
  late final UserStore _userStore;
  late final SearchStore _searchStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _mentorStore = Provider.of<MentorStore>(context, listen: false);
    _commonStore = Provider.of<CommonStore>(context, listen: false);
    _userStore = Provider.of<UserStore>(context, listen: false);
    _searchStore = Provider.of<SearchStore>(context, listen: false);
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
      child: Stack(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.horizontal_padding),
                      child: Observer(
                        builder: (context) {
                          return NeumorphismButton(
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
                          );
                        },
                      ),
                    ),
                  ),
                  TextFieldWidget(
                    isObscure: false,
                    margin: const EdgeInsets.only(
                      top: Dimens.extra_large_vertical_margin,
                      bottom: Dimens.large_vertical_margin,
                    ),
                    textController: _searchController,
                    textStyle: const TextStyle(fontSize: Dimens.small_text),
                    hint:
                        AppLocalizations.of(context).translate('mentor_search'),
                    icon: const Icon(
                      Icons.search_rounded,
                      color: Colors.white70,
                    ),
                    hasBorder: true,
                    onChanged: (String value) {
                      _searchStore.onChangeSearchKey(value);
                    },
                    onFieldSubmitted: (value) {
                      _mentorStore.resetPage().then(
                        (_) {
                          _refreshController.requestRefresh();
                        },
                      );
                    },
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Observer(
                          builder: (_) {
                            return FilterButtonTag(
                              text: AppLocalizations.of(context)
                                  .translate("category_translate"),
                              isFilted: _searchStore.selectedCategory != null,
                              selectedTitleItems: _searchStore
                                          .selectedCategory !=
                                      null
                                  ? [
                                      TitleItem(
                                        id: _searchStore.selectedCategory!.id,
                                        title:
                                            _searchStore.selectedCategory!.name,
                                      )
                                    ]
                                  : [],
                              titleItems: _searchStore.categoryList
                                  .map(
                                    (item) => TitleItem(
                                        id: item.id, title: item.name),
                                  )
                                  .toList(),
                              onValueChange: (item) {
                                _searchStore.changeSelectedCategory(item.id);

                                return _searchStore.selectedCategory != null
                                    ? [
                                        TitleItem(
                                          id: _searchStore.selectedCategory!.id,
                                          title: _searchStore
                                              .selectedCategory!.name,
                                        )
                                      ]
                                    : [];
                              },
                              callback: () {
                                _mentorStore.resetPage().then(
                                  (_) {
                                    _refreshController.requestRefresh();
                                  },
                                );
                              },
                            );
                          },
                        ),
                        Observer(
                          builder: (_) {
                            return FilterButtonTag(
                              text: AppLocalizations.of(context)
                                  .translate("skill_translate"),
                              isFilted:
                                  _searchStore.selectedSkillList.isNotEmpty,
                              selectedTitleItems: _searchStore.selectedSkillList
                                  .map(
                                    (item) => TitleItem(
                                        id: item.id,
                                        title: item.description ?? "Unknown"),
                                  )
                                  .toList(),
                              titleItems: _searchStore.skillList
                                  .map(
                                    (item) => TitleItem(
                                        id: item.id,
                                        title: item.description ?? "Unknown"),
                                  )
                                  .toList(),
                              onValueChange: (item) {
                                _searchStore.updateSelectedSkills(item.id);

                                return _searchStore.selectedSkillList
                                    .map(
                                      (item) => TitleItem(
                                          id: item.id,
                                          title: item.description ?? "Unknown"),
                                    )
                                    .toList();
                              },
                              callback: () {
                                _mentorStore.resetPage().then(
                                  (_) {
                                    _refreshController.requestRefresh();
                                  },
                                );
                              },
                            );
                          },
                        ),
                        Observer(
                          builder: (_) {
                            return FilterButtonTag(
                              text: AppLocalizations.of(context)
                                  .translate("orderby_translate"),
                              isFilted: true,
                              marginHeight:
                                  DeviceUtils.getScaledHeight(context, 0.37),
                              selectedTitleItems: [
                                TitleItem(
                                  id: _searchStore.sortType.index,
                                  title: _searchStore.sortType
                                      .toLocaleString(context),
                                ),
                              ],
                              titleItems: OrderType.values
                                  .map(
                                    (item) => TitleItem(
                                      id: item.index,
                                      title: item.toLocaleString(context),
                                    ),
                                  )
                                  .toList(),
                              onValueChange: (item) {
                                _searchStore
                                    .setOrder(OrderType.values[item.id]);
                                return [
                                  TitleItem(
                                    id: _searchStore.sortType.index,
                                    title: _searchStore.sortType
                                        .toLocaleString(context),
                                  ),
                                ];
                              },
                              callback: () {
                                _mentorStore.resetPage().then(
                                  (_) {
                                    _refreshController.requestRefresh();
                                  },
                                );
                              },
                            );
                          },
                        ),
                        Observer(
                          builder: (_) {
                            return FilterButtonTag(
                              text: AppLocalizations.of(context)
                                  .translate("sort_translate"),
                              isFilted: true,
                              marginHeight:
                                  DeviceUtils.getScaledHeight(context, 0.37),
                              selectedTitleItems: [
                                TitleItem(
                                  id: _searchStore.orderByType.index,
                                  title: _searchStore.orderByType
                                      .toLocaleString(context),
                                ),
                              ],
                              titleItems: OrderByType.values
                                  .map(
                                    (item) => TitleItem(
                                      id: item.index,
                                      title: item.toLocaleString(context),
                                    ),
                                  )
                                  .toList(),
                              onValueChange: (item) {
                                _searchStore
                                    .setOrderBy(OrderByType.values[item.id]);

                                return [
                                  TitleItem(
                                    id: _searchStore.orderByType.index,
                                    title: _searchStore.orderByType
                                        .toLocaleString(context),
                                  ),
                                ];
                              },
                              callback: () {
                                _mentorStore.resetPage().then(
                                  (_) {
                                    _refreshController.requestRefresh();
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: Dimens.large_vertical_margin,
                  ),
                  Expanded(
                    child: Observer(
                      builder: (_) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(
                              Dimens.kBorderMaxRadiusValue),
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

                                await _mentorStore
                                    .searchMentors(_searchStore.toJson())
                                    .then((_) {
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
                                await _mentorStore
                                    .searchMentors(_searchStore.toJson())
                                    .then((_) {
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
                              children: List.generate(
                                      _mentorStore.length, (i) => i)
                                  .map(
                                    (i) => ShortImformationItem(
                                      mentorModel: _mentorStore.at(i),
                                      onTapViewDetail: () {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) => MentorProfile(
                                                idMentor:
                                                    _mentorStore.at(i).id),
                                          ),
                                        );
                                      },
                                    ),
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
        ],
      ),
    );
  }
}

class FilterButtonTag extends StatelessWidget {
  FilterButtonTag({
    Key? key,
    required this.text,
    required this.isFilted,
    required this.titleItems,
    required this.selectedTitleItems,
    this.onValueChange,
    this.callback,
    this.marginHeight,
  }) : super(key: key);

  final String text;
  final bool isFilted;
  final List<TitleItem> titleItems;
  final List<TitleItem> selectedTitleItems;
  final List<TitleItem> Function(TitleItem)? onValueChange;
  final VoidCallback? callback;
  final double? marginHeight;

  //store:----------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();

  @override
  Widget build(BuildContext context) {
    return HeroPopupRoute<TitleItem>(
      colorSourceCard: Colors.transparent,
      colorDestinationCard: Colors.transparent,
      marginDestinationCard: EdgeInsets.symmetric(
        horizontal: DeviceUtils.getScaledWidth(context, 0.15),
        vertical: marginHeight ?? DeviceUtils.getScaledHeight(context, 0.25),
      ),
      marginSourceCard:
          const EdgeInsets.symmetric(horizontal: Dimens.horizontal_margin),
      sourceChild: GlassmorphismContainer(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: Dimens.small_vertical_padding,
            horizontal: Dimens.small_horizontal_padding,
          ),
          width: DeviceUtils.getScaledWidth(context, 0.25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: Dimens.small_text,
                    color: isFilted ? Colors.orange : Colors.white70),
              ),
              const SizedBox(
                height: Dimens.vertical_margin,
              ),
              Icon(
                Icons.fiber_manual_record,
                color: isFilted ? Colors.orange : Colors.white70,
                size: Dimens.small_text,
              ),
            ],
          ),
        ),
        blur: Properties.hevily_blur_glass_morphism,
        opacity: Properties.hevily_opacity_glass_morphism,
      ),
      destinationChild: ListFilterPopup(
        title: text,
        filters: titleItems,
        selectedFilter: selectedTitleItems,
        selectedFilterColor: Colors.orange,
        unselectedFilterColor: Colors.white70,
        onValueChange: (itemSelect) {
          return onValueChange?.call(itemSelect) ?? [];
        },
      ),
      callback: (_) {
        callback?.call();
      },
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
                    url: mentorModel.avatar,
                    radius: width * 0.45,
                    borderRadius: BorderRadius.circular(0.0),
                    onTap: onTapViewDetail,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade600.withOpacity(0.65),
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
                "Major: ${mentorModel.userMentor.category.name}",
                style: const TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
              child: ReadMoreText(
                mentorModel.userMentor.introduction,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
                trimLines: 3,
                trimLength: 50,
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

class TitleItem extends Equatable {
  final int id;
  final String title;

  const TitleItem({
    required this.id,
    required this.title,
  });

  @override
  String toString() {
    return title;
  }

  @override
  List<Object?> get props => [id];
}

class ListFilterPopup extends StatefulWidget {
  const ListFilterPopup({
    Key? key,
    required this.title,
    required this.filters,
    required this.selectedFilter,
    required this.selectedFilterColor,
    required this.unselectedFilterColor,
    this.onValueChange,
  }) : super(key: key);

  final String title;
  final List<TitleItem> filters;
  final List<TitleItem> selectedFilter;
  final Color selectedFilterColor;
  final Color unselectedFilterColor;

  final List<TitleItem> Function(TitleItem)? onValueChange;

  @override
  State<ListFilterPopup> createState() => _ListFilterPopupState();
}

class _ListFilterPopupState extends State<ListFilterPopup> {
  late List<TitleItem> selectedFilter;

  @override
  void initState() {
    super.initState();

    selectedFilter = widget.selectedFilter;
  }

  @override
  Widget build(BuildContext context) {
    return GlassmorphismContainer(
      blur: Properties.blur_glass_morphism,
      opacity: Properties.opacity_glass_morphism,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin:
                const EdgeInsets.symmetric(vertical: Dimens.vertical_padding),
            padding:
                const EdgeInsets.symmetric(horizontal: Dimens.vertical_padding),
            child: Text(
              widget.title,
              style: TextStyle(
                  color: widget.selectedFilterColor,
                  fontSize: Dimens.medium_text,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Divider(
            thickness: 0.5,
            color: Color.alphaBlend(
                widget.selectedFilterColor.withAlpha(100), Colors.white),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: widget.filters
                  .map(
                    (object) => ListTile(
                      dense: true,
                      title: Text(
                        object.title,
                        style: TextStyle(
                          fontSize: Dimens.small_text,
                          color: selectedFilter.contains(object)
                              ? widget.selectedFilterColor
                              : widget.unselectedFilterColor,
                        ),
                      ),
                      onTap: () {
                        setState(
                          () {
                            selectedFilter =
                                widget.onValueChange?.call(object) ?? [];
                          },
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
