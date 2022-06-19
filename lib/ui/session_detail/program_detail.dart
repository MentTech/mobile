import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/common/program/program.dart';
import 'package:mobile/models/mentor/mentor.dart';
import 'package:mobile/models/rate/rate.dart';
import 'package:mobile/stores/common/common_store.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/ui/mentor_detail/mentor_profile.dart';
import 'package:mobile/utils/application/application_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/container/image_container/network_image_widget.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:mobile/widgets/item/comment_item.dart';
import 'package:mobile/widgets/star_widget/start_rate_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:readmore/readmore.dart';
import 'package:mobile/utils/extension/datetime_extension.dart';
import 'package:shimmer/shimmer.dart';

class ProgramDetailContainer extends StatefulWidget {
  const ProgramDetailContainer({
    Key? key,
    required this.programDetail,
    required this.mentorModel,
  }) : super(key: key);

  final Program programDetail;
  final MentorModel? mentorModel;

  @override
  State<ProgramDetailContainer> createState() => _ProgramDetailContainerState();
}

class _ProgramDetailContainerState extends State<ProgramDetailContainer> {
  // store:---------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();

  late final CommonStore _commonStore;

  // controller:----------------------------------------------------------------
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();

    _commonStore = Provider.of<CommonStore>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimens.kBorderMaxRadiusValue),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  widget.programDetail.title +
                      "\n${AppLocalizations.of(context).translate('with_translate')} " +
                      (widget.mentorModel?.name ?? ""),
                  style: const TextStyle(
                    fontSize: Dimens.large_text,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: NetworkImageWidget(url: widget.mentorModel?.avatar),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: Dimens.vertical_margin,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GlassmorphismContainer(
                  padding: const EdgeInsets.symmetric(
                    vertical: Dimens.more_small_vertical_padding,
                    horizontal: Dimens.more_small_horizontal_padding,
                  ),
                  child: SymbolsItem(
                    symbol: const Icon(
                      Icons.monetization_on_outlined,
                      size: Dimens.large_text,
                      color: Colors.white70,
                    ),
                    child: Text(
                      widget.programDetail.credit.toString(),
                      style: const TextStyle(
                        fontSize: Dimens.small_text,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  blur: Properties.blur_glass_morphism,
                  opacity: Properties.opacity_glass_morphism,
                ),
                const SizedBox(
                  width: Dimens.vertical_margin,
                ),
                widget.mentorModel != null
                    ? Text(
                        widget.mentorModel?.userMentor.category.name ?? "",
                        style: const TextStyle(
                          fontSize: Dimens.lightly_medium_text,
                          color: Colors.white70,
                        ),
                      )
                    : _ShimmerSection(
                        child: Container(
                          height: Dimens.medium_text,
                          width: 100,
                          margin: const EdgeInsets.symmetric(
                              vertical: Dimens.vertical_margin),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: Dimens.kMaxBorderRadius,
                          ),
                        ),
                      ),
              ],
            ),
          ),
          widget.programDetail.createAt != null
              ? Text(
                  "${AppLocalizations.of(context).translate('create_at_translate')} ${widget.programDetail.createAt!.toFulltimeString()}",
                  style: const TextStyle(
                    fontSize: Dimens.small_text,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                )
              : const SizedBox(),
          ReadMoreText(
            widget.programDetail.detail,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: Dimens.small_text,
            ),
            trimLines: 5,
            trimMode: TrimMode.Line,
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              const Divider(
                color: Colors.white70,
                thickness: 2.5,
                indent: Dimens.large_horizontal_margin,
                endIndent: Dimens.large_horizontal_margin,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).translate("discusstion"),
                        style: const TextStyle(
                          fontSize: Dimens.lightly_medium_text,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Divider(
                        color: _themeStore.themeColor,
                        thickness: 1,
                        indent: Dimens.large_horizontal_margin,
                        endIndent: Dimens.large_horizontal_margin,
                      ),
                    ],
                  ),
                  StarRateWidget(
                    rating: widget.programDetail.averageRating?.average ?? 0.0,
                    count: widget.programDetail.averageRating?.count ?? 0,
                  ),
                ],
              ),
            ],
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
                      if (widget.mentorModel != null &&
                          _commonStore.prevProgramRatePage()) {
                        _commonStore.callback =
                            () => _refreshController.refreshCompleted();

                        await _commonStore
                            .fetchProgramRateList(
                                widget.mentorModel!.id, widget.programDetail.id)
                            .then(
                          (_) {
                            FlushbarHelper.createSuccess(
                              message: AppLocalizations.of(context)
                                  .translate("home_tv_success"),
                              title: AppLocalizations.of(context)
                                  .translate('load_success'),
                            ).show(context);
                          },
                        );
                      } else {
                        _refreshController.refreshCompleted();
                      }
                    },
                    onLoading: () async {
                      if (widget.mentorModel != null &&
                          _commonStore.nextProgramRatePage()) {
                        await _commonStore
                            .fetchProgramRateList(
                                widget.mentorModel!.id, widget.programDetail.id)
                            .then((_) {
                          FlushbarHelper.createSuccess(
                            message: AppLocalizations.of(context)
                                .translate("home_tv_success"),
                            title: AppLocalizations.of(context)
                                .translate('load_success'),
                          ).show(context);

                          _refreshController.loadComplete();
                        });
                      } else {
                        _refreshController.loadComplete();
                      }
                    },
                    child: ListView.builder(
                      itemBuilder: (_, int index) {
                        RateModel rateModel =
                            _commonStore.getRateCommentAt(index);
                        return CommentItem(
                          rateModel: rateModel,
                        );
                      },
                      itemCount: _commonStore.programLengthList,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _ShimmerSection({required Widget child}) {
    return Shimmer.fromColors(
      child: child,
      baseColor: _themeStore.light.withOpacity(0.5),
      highlightColor: _themeStore.themeColorfulColorShimmer,
      direction: ShimmerDirection.ltr,
      period: const Duration(milliseconds: 3000),
    );
  }
}
