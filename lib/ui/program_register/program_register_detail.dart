import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/models/common/program/program.dart';
import 'package:mobile/models/mentor/mentor.dart';
import 'package:mobile/models/rate/rate.dart';
import 'package:mobile/stores/common/common_store.dart';
import 'package:mobile/stores/mentor/mentor_store.dart';
import 'package:mobile/ui/mentor_detail/mentor_profile.dart';
import 'package:mobile/utils/application/application_utils.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/container/image_container/network_image_widget.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:mobile/widgets/item/comment_item.dart';
import 'package:mobile/widgets/star_widget/start_rate_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mobile/utils/extension/datetime_extension.dart';

class ProgramRegisterDetail extends StatefulWidget {
  const ProgramRegisterDetail({Key? key}) : super(key: key);

  @override
  State<ProgramRegisterDetail> createState() => _ProgramRegisterDetailState();
}

class _ProgramRegisterDetailState extends State<ProgramRegisterDetail> {
  // store:---------------------------------------------------------------------

  late final MentorStore _mentorStore;
  late final CommonStore _commonStore;

  // controller:----------------------------------------------------------------
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();

    _mentorStore = Provider.of<MentorStore>(context, listen: false);
    _commonStore = Provider.of<CommonStore>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (_mentorStore.isLoading ||
          !_mentorStore.hasMentor ||
          !_mentorStore.hasProgram) {
        return _buildProgramShimmerLoading();
      } else {
        return _buildContent();
      }
    });
  }

  Widget _buildContent() {
    return ClipRRect(
      borderRadius: Dimens.kMaxBorderRadius,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgramSection(),
            _buildReviewSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgramSection() {
    return Observer(builder: (_) {
      Program program = _mentorStore.program!;
      MentorModel mentorModel = _mentorStore.mentorModel!;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      program.title +
                          "\n${AppLocalizations.of(context).translate('with_translate')} " +
                          mentorModel.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(height: 1.5),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: NetworkImageWidget(url: mentorModel.avatar),
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
                    symbol: IconTheme(
                      data: Theme.of(context)
                          .iconTheme
                          .copyWith(size: Dimens.large_text),
                      child: const Icon(Icons.monetization_on_outlined),
                    ),
                    child: Text(
                      " ${program.credit}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  blur: Properties.blur_glass_morphism,
                  opacity: Properties.opacity_glass_morphism,
                ),
                const SizedBox(
                  width: Dimens.vertical_margin,
                ),
                Text(
                  mentorModel.userMentor.category.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          program.createAt != null
              ? Text(
                  "${AppLocalizations.of(context).translate('create_at_translate')} ${program.createAt!.toFulltimeString()}",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(height: 1.5))
              : const SizedBox(),
          // ReadMoreText(
          //   program.detail,
          //   style: TextStyle(
          //     color: _themeStore.reverseThemeColor,
          //     fontSize: Dimens.small_text,
          //   ),
          //   trimLines: 5,
          //   trimMode: TrimMode.Line,
          // ),
          Html(
            data: program.detail,
            shrinkWrap: true,
            style: {
              "li": Style(
                color: Theme.of(context).indicatorColor,
                fontSize: const FontSize(Dimens.small_text),
              ),
              "p": Style(
                color: Theme.of(context).indicatorColor,
                fontSize: const FontSize(Dimens.small_text),
              ),
              "span": Style(
                color: Theme.of(context).indicatorColor,
                fontSize: const FontSize(Dimens.small_text),
              ),
            },
          ),
        ],
      );
    });
  }

  Widget _buildReviewSection() {
    return Column(
      children: [
        const SizedBox(
          height: Dimens.large_vertical_margin,
        ),
        _buildReviewHeader(),
        _buildReviewItemSection(),
      ],
    );
  }

  Widget _buildReviewHeader() {
    return Observer(
      builder: (_) {
        Program program = _mentorStore.program!;

        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context).translate("discusstion"),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                StarRateWidget(
                  rating: program.averageRating?.average ?? 0.0,
                  count: program.averageRating?.count ?? 0,
                ),
              ],
            ),
            const SizedBox(
              height: Dimens.vertical_margin,
            ),
            Stack(
              children: [
                SizedBox(
                  width: DeviceUtils.getScaledWidth(context, 0.5),
                  child: Divider(
                    color: Theme.of(context).highlightColor,
                    thickness: 3,
                    indent: Dimens.large_horizontal_margin,
                    endIndent: Dimens.large_horizontal_margin,
                  ),
                ),
                SizedBox(
                  width: DeviceUtils.getScaledWidth(context, 1.0),
                  child: Divider(
                    color: Theme.of(context).indicatorColor,
                    thickness: 1,
                    indent: Dimens.large_horizontal_margin,
                    endIndent: Dimens.large_horizontal_margin,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildReviewItemSection() {
    return Observer(
      builder: (_) {
        Program program = _mentorStore.program!;
        MentorModel mentorModel = _mentorStore.mentorModel!;

        return ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.kBorderMaxRadiusValue),
          child: SizedBox(
            height: DeviceUtils.getScaledHeight(context, 0.5),
            child: SmartRefresher(
              controller: _refreshController,
              enablePullUp: true,
              enablePullDown: true,
              header: ApplicationUtils.fetchHeaderStatus(context),
              footer: ApplicationUtils.fetchFooterStatus(),
              onRefresh: () async {
                if (_commonStore.prevProgramRatePage()) {
                  _commonStore.callback =
                      () => _refreshController.refreshCompleted();

                  await _commonStore
                      .fetchProgramRateList(mentorModel.id, program.id)
                      .then(
                    (_) {
                      // FlushbarHelper.createSuccess(
                      //   message: AppLocalizations.of(context)
                      //       .translate("home_tv_success"),
                      //   title: AppLocalizations.of(context)
                      //       .translate('load_success'),
                      // ).show(context);
                    },
                  );
                } else {
                  _refreshController.refreshCompleted();
                }
              },
              onLoading: () async {
                if (_commonStore.nextProgramRatePage()) {
                  await _commonStore
                      .fetchProgramRateList(mentorModel.id, program.id)
                      .then((_) {
                    // FlushbarHelper.createSuccess(
                    //   message: AppLocalizations.of(context)
                    //       .translate("home_tv_success"),
                    //   title: AppLocalizations.of(context)
                    //       .translate('load_success'),
                    // ).show(context);

                    _refreshController.loadComplete();
                  });
                } else {
                  _refreshController.loadComplete();
                }
              },
              child: ListView.builder(
                itemBuilder: (_, int index) {
                  RateModel rateModel = _commonStore.getRateCommentAt(index);
                  return CommentItem(
                    rateModel: rateModel,
                  );
                },
                itemCount: _commonStore.programLengthList,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgramShimmerLoading() {
    return ProgramRegisterDetailShimmer(
      baseColor: Colors.white70.withOpacity(0.5),
      highlightColor: Theme.of(context).splashColor,
    );
  }
}

class ProgramRegisterDetailShimmer extends StatelessWidget {
  const ProgramRegisterDetailShimmer({
    Key? key,
    required this.baseColor,
    required this.highlightColor,
  }) : super(key: key);

  final Color baseColor;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ShimmerSection(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: Dimens.vertical_margin),
                        height: Dimens.extra_large_text,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: Dimens.kMaxBorderRadius,
                        ),
                      ),
                    ),
                    _ShimmerSection(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: Dimens.vertical_margin),
                        height: Dimens.extra_large_text,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: Dimens.kMaxBorderRadius,
                        ),
                      ),
                    ),
                    _ShimmerSection(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: Dimens.vertical_margin),
                        height: Dimens.medium_text,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: Dimens.kMaxBorderRadius,
                        ),
                      ),
                    ),
                    _ShimmerSection(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: Dimens.vertical_margin),
                        height: Dimens.medium_text,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: Dimens.kMaxBorderRadius,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: Dimens.horizontal_margin,
              ),
              _ShimmerSection(
                child: Container(
                  width: DeviceUtils.getScaledWidth(context, 0.3),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: Dimens.kMaxBorderRadius,
                  ),
                  child: const AspectRatio(aspectRatio: 1 / 1),
                ),
              ),
            ],
          ),
          _ShimmerSection(
            child: Container(
              margin: const EdgeInsets.symmetric(
                  vertical: Dimens.large_vertical_margin),
              height: Dimens.medium_text * 8,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: Dimens.kMaxBorderRadius,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).translate("discusstion"),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  _ShimmerSection(
                    child: Container(
                      height: Dimens.medium_text,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: Dimens.kMaxBorderRadius,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: Dimens.vertical_margin,
              ),
              Stack(
                children: [
                  SizedBox(
                    width: DeviceUtils.getScaledWidth(context, 0.5),
                    child: Divider(
                      color: highlightColor,
                      thickness: 3,
                      indent: Dimens.large_horizontal_margin,
                      endIndent: Dimens.large_horizontal_margin,
                    ),
                  ),
                  SizedBox(
                    width: DeviceUtils.getScaledWidth(context, 1.0),
                    child: Divider(
                      color: highlightColor,
                      thickness: 1,
                      indent: Dimens.large_horizontal_margin,
                      endIndent: Dimens.large_horizontal_margin,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemBuilder: (_, index) => ListTile(
                leading: _ShimmerSection(
                  child: Container(
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: Dimens.kMaxBorderRadius,
                    ),
                    child: const AspectRatio(aspectRatio: 1 / 1),
                  ),
                ),
                title: _ShimmerSection(
                  child: Container(
                    height: Dimens.medium_text,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        vertical: Dimens.vertical_margin),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: Dimens.kMaxBorderRadius,
                    ),
                  ),
                ),
                subtitle: _ShimmerSection(
                  child: Container(
                    height: Dimens.medium_text,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        vertical: Dimens.vertical_margin),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: Dimens.kMaxBorderRadius,
                    ),
                  ),
                ),
                trailing: _ShimmerSection(
                  child: Container(
                    height: Dimens.medium_text,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: Dimens.kMaxBorderRadius,
                    ),
                  ),
                ),
              ),
              itemCount: 5,
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
      baseColor: baseColor,
      highlightColor: highlightColor,
      direction: ShimmerDirection.ltr,
      period: const Duration(milliseconds: 3000),
    );
  }
}
