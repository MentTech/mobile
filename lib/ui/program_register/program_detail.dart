import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/common/program/program.dart';
import 'package:mobile/models/mentor/mentor.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/widgets/container/image_container/network_image_widget.dart';

class ProgramDetailContainer extends StatelessWidget {
  ProgramDetailContainer({
    Key? key,
    required this.programDetail,
    required this.mentorModel,
  }) : super(key: key);

  final Program programDetail;
  final MentorModel mentorModel;

  final ThemeStore _themeStore = getIt<ThemeStore>();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimens.kBorderMaxRadiusValue),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
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
              // stars
              // topic
            ],
          ),
          // created at
          // introduction
          // discusstion
        ],
      ),
    );
  }
}
