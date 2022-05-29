import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/common/program/program.dart';
import 'package:mobile/models/mentor/mentor.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/widgets/container/image_container/network_image_widget.dart';
import 'package:mobile/widgets/star_widget/start_rate_widget.dart';
import 'package:readmore/readmore.dart';
import 'package:mobile/utils/extension/datetime_extension.dart';

class ProgramDetailContainer extends StatelessWidget {
  ProgramDetailContainer({
    Key? key,
    required this.programDetail,
    required this.mentorModel,
  }) : super(key: key);

  final Program programDetail;
  final MentorModel mentorModel;

  final ThemeStore _themeStore = getIt<ThemeStore>();

  // final RefreshController _refreshController = RefreshController();

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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      programDetail.title + " with " + mentorModel.name,
                      style: const TextStyle(
                        fontSize: Dimens.large_text,
                        color: Colors.white,
                        height: 1.5,
                      ),
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
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // GlassmorphismContainer(
              //   child: SymbolsItem(
              //     symbol: const Icon(
              //       Icons.monetization_on_outlined,
              //       size: Dimens.large_text,
              //     ),
              //     child: Text(
              //       "programDetail.credit.toString()",
              //       style: const TextStyle(
              //         fontSize: Dimens.small_text,
              //       ),
              //     ),
              //   ),
              //   blur: Properties.blur_glass_morphism,
              //   opacity: Properties.blur_glass_morphism,
              // ),
              Text(
                mentorModel.userMentor.category.name,
                style: const TextStyle(
                  fontSize: Dimens.lightly_medium_text,
                  color: Colors.white70,
                  height: 2,
                ),
              ),
            ],
          ),
          Text(
            "Created at ${programDetail.createAt.toFulltimeString()}",
            style: const TextStyle(
              fontSize: Dimens.small_text,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
          ReadMoreText(
            programDetail.detail,
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
              // const Divider(
              //   color: Colors.white70,
              //   thickness: 2.5,
              //   indent: Dimens.large_horizontal_margin,
              //   endIndent: Dimens.large_horizontal_margin,
              // ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Discusstion",
                        style: TextStyle(
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
                    rating: programDetail.averageRating!.average,
                    count: programDetail.averageRating!.count,
                  ),
                ],
              ),
            ],
          ),
          // Expanded(
          //     child: Container(
          //   color: Colors.amber,
          // ))
          // Observer(
          //   builder: (_) {
          //     CommonStore commonStore =
          //         Provider.of<CommonStore>(context, listen: false);
          //     return ClipRRect(
          //       borderRadius:
          //           BorderRadius.circular(Dimens.kBorderMaxRadiusValue),
          //       child: SmartRefresher(
          //         controller: _refreshController,
          //         enablePullUp: true,
          //         enablePullDown: true,
          //         header: ApplicationUtils.fetchHeaderStatus(context),
          //         footer: ApplicationUtils.fetchFooterStatus(),
          //         onRefresh: () async {
          //           if (commonStore.prevProgramRatePage()) {
          //             commonStore.callback =
          //                 () => _refreshController.refreshCompleted();

          //             await commonStore
          //                 .fetchProgramRateList(
          //                     mentorModel.id, programDetail.id)
          //                 .then((_) {
          //               // if (tutorStore.isSearch) {
          //               //   DeviceUtils.showSnackBar(
          //               //       context,
          //               //       AppLocalizations.of(context)
          //               //           .translate("search_tutor_results")
          //               //           .format([
          //               //         tutorStore.countTutors.toString()
          //               //       ]));
          //               // }
          //             });
          //           } else {
          //             _refreshController.refreshCompleted();
          //           }
          //         },
          //         onLoading: () async {
          //           if (commonStore.nextProgramRatePage()) {
          //             await commonStore
          //                 .fetchProgramRateList(
          //                     mentorModel.id, programDetail.id)
          //                 .then((_) {
          //               //

          //               _refreshController.loadComplete();
          //             });
          //           } else {
          //             _refreshController.loadComplete();
          //           }
          //         },
          //         child: ListView.builder(
          //           itemBuilder: (BuildContext context, int index) {
          //             RateModel rateModel = commonStore.getProgramAt(0);
          //             return TextContainerExample(
          //                 title: rateModel.id.toString(),
          //                 contend: rateModel.comment);
          //           },
          //           itemCount: 5, //commonStore.programLengthList,
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
