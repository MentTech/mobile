import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/models/common/program/program.dart';
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
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:mobile/utils/extension/datetime_extension.dart';

class ProgramDetailContainer extends StatefulWidget {
  const ProgramDetailContainer({
    Key? key,
    required this.programDetail,
  }) : super(key: key);

  final Program programDetail;

  @override
  State<ProgramDetailContainer> createState() => _ProgramDetailContainerState();
}

class _ProgramDetailContainerState extends State<ProgramDetailContainer> {
  // store:---------------------------------------------------------------------

  late final CommonStore _commonStore;
  late final MentorStore _mentorStore;

  // controller:----------------------------------------------------------------
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();

    _mentorStore = Provider.of<MentorStore>(context, listen: false);
    _mentorStore.fetchAMentor(widget.programDetail.mentorId);

    _commonStore = Provider.of<CommonStore>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimens.kBorderMaxRadiusValue),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Dimens.vertical_padding,
            horizontal: Dimens.horizontal_padding,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: kBottomNavigationBarHeight,
              ),
              _buildHeaderContent(),
              _buildCoinContent(),
              widget.programDetail.createAt != null
                  ? Text(
                      "${AppLocalizations.of(context).translate('create_at_translate')} ${widget.programDetail.createAt!.toFulltimeString()}",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(height: 1.5),
                    )
                  : const SizedBox(),
              //     // ReadMoreText(
              //     //   widget.programDetail.detail,
              //     //   style: const TextStyle(
              //     //     color: Colors.white70,
              //     //     fontSize: Dimens.small_text,
              //     //   ),
              //     //   trimLines: 5,
              //     //   trimMode: TrimMode.Line,
              //     // ),

              Html(
                data: widget.programDetail.detail,
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
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: Dimens.vertical_margin),
                child: Divider(
                  color: Theme.of(context).highlightColor,
                  thickness: 1.5,
                ),
              ),

// contact infor inplement here

              Container(
                margin: const EdgeInsets.symmetric(
                    vertical: Dimens.vertical_margin),
                child: Divider(
                  color: Theme.of(context).highlightColor,
                  thickness: 1.5,
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
                      StarRateWidget(
                        rating:
                            widget.programDetail.averageRating?.average ?? 0.0,
                        count: widget.programDetail.averageRating?.count ?? 0,
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
              ),

              SizedBox(
                height: DeviceUtils.getScaledHeight(context, 0.5),
                child: Observer(
                  builder: (_) {
                    return SmartRefresher(
                      controller: _refreshController,
                      enablePullUp: true,
                      enablePullDown: true,
                      header: ApplicationUtils.fetchHeaderStatus(context),
                      footer: ApplicationUtils.fetchFooterStatus(),
                      onRefresh: () async {
                        if (_mentorStore.hasMentor &&
                            _commonStore.prevProgramRatePage()) {
                          _commonStore.callback =
                              () => _refreshController.refreshCompleted();

                          await _commonStore
                              .fetchProgramRateList(_mentorStore.getMentor!.id,
                                  widget.programDetail.id)
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
                        if (_mentorStore.hasMentor &&
                            _commonStore.nextProgramRatePage()) {
                          await _commonStore
                              .fetchProgramRateList(_mentorStore.getMentor!.id,
                                  widget.programDetail.id)
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
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, int index) {
                          RateModel rateModel =
                              _commonStore.getRateCommentAt(index);
                          return CommentItem(
                            rateModel: rateModel,
                          );
                        },
                        itemCount: _commonStore.programLengthList,
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

  Container _buildCoinContent() {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Dimens.large_vertical_margin,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GlassmorphismContainer(
            padding: const EdgeInsets.symmetric(
              vertical: Dimens.more_small_vertical_padding,
              horizontal: Dimens.semi_horizontal_padding,
            ),
            child: SymbolsItem(
              spacing: Dimens.more_horizontal_margin,
              symbol: IconTheme(
                data: Theme.of(context).iconTheme,
                child: const Icon(
                  Icons.monetization_on_outlined,
                  size: Dimens.large_text,
                ),
              ),
              child: Text(
                widget.programDetail.credit.toString(),
                style: Theme.of(context).textTheme.bodySmall!,
              ),
            ),
            blur: Properties.blur_glass_morphism,
            opacity: Properties.opacity_glass_morphism,
          ),
          const SizedBox(
            width: Dimens.vertical_margin,
          ),
          Observer(
            builder: (_) {
              if (_mentorStore.hasMentor) {
                return Text(
                  _mentorStore.getMentor!.userMentor.category.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                );
              } else {
                return ApplicationUtils.shimmerSection(
                  context,
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
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Row _buildHeaderContent() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 3,
          child: Observer(builder: (_) {
            return Text(
              widget.programDetail.title +
                  "\n${AppLocalizations.of(context).translate('with_translate')} " +
                  (_mentorStore.getMentor?.name ??
                      AppLocalizations.of(context)
                          .translate("unknown_translate")),
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(height: 1.5),
            );
          }),
        ),
        Expanded(
          flex: 1,
          child: Observer(builder: (_) {
            return NetworkImageWidget(url: _mentorStore.getMentor?.avatar);
          }),
        ),
      ],
    );
  }
}
