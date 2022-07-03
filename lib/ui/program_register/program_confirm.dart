import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/common/program/program.dart';
import 'package:mobile/models/mentor/mentor.dart';
import 'package:mobile/stores/form/program_register_form_store.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/ui/mentor_detail/mentor_profile.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/container/image_container/network_image_widget.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:mobile/utils/extension/datetime_extension.dart';
import 'package:shimmer/shimmer.dart';

class ProgramConfirmContainer extends StatelessWidget {
  ProgramConfirmContainer({
    Key? key,
    required this.registerInformation,
    required this.mentorModel,
    required this.program,
  }) : super(key: key);

  final ThemeStore _themeStore = getIt<ThemeStore>();
  final RegisterInformation registerInformation;
  final MentorModel mentorModel;
  final Program? program;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: Dimens.kMaxBorderRadius,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgramSection(
              context,
              mentorModel: mentorModel,
              program: program,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
              child: Divider(
                color: Theme.of(context).highlightColor,
                thickness: 2.0,
              ),
            ),
            _buildMenteeInforSection(
              context,
              registerInformation: registerInformation,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgramSection(
    BuildContext context, {
    required MentorModel mentorModel,
    required Program? program,
  }) {
    if (null != program) {
      return _buildFetchedProgramSection(context, program, mentorModel);
    } else {
      return _buildUnFetchedProgramSection(context, mentorModel);
    }
  }

  Widget _buildFetchedProgramSection(
      BuildContext context, Program program, MentorModel mentorModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                program.title +
                    "\n${AppLocalizations.of(context).translate('with_translate')} " +
                    mentorModel.name,
                style: TextStyle(
                  fontSize: Dimens.large_text,
                  color: Theme.of(context).indicatorColor,
                  height: 1.5,
                ),
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
                  symbol: Icon(
                    Icons.monetization_on_outlined,
                    size: Dimens.large_text,
                    color: Theme.of(context).indicatorColor,
                  ),
                  child: Text(
                    " ${program.credit}",
                    style: TextStyle(
                      fontSize: Dimens.small_text,
                      color: Theme.of(context).indicatorColor,
                    ),
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
                style: TextStyle(
                  fontSize: Dimens.lightly_medium_text,
                  color: Theme.of(context).indicatorColor,
                ),
              ),
            ],
          ),
        ),
        program.createAt != null
            ? Text(
                "${AppLocalizations.of(context).translate('create_at_translate')} ${program.createAt!.toFulltimeString()}",
                style: TextStyle(
                  fontSize: Dimens.small_text,
                  color: Theme.of(context).indicatorColor,
                  height: 1.5,
                ),
              )
            : const SizedBox(),
        // ReadMoreText(
        //   program.detail,
        //   style: TextStyle(
        //     color: Theme.of(context).indicatorColor,
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
          },
        ),
      ],
    );
  }

  Widget _buildUnFetchedProgramSection(
      BuildContext context, MentorModel mentorModel) {
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
                  _ShimmerSection(
                    context,
                    child: Container(
                      height: Dimens.medium_text * 2,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          vertical: Dimens.vertical_margin),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: Dimens.kMaxBorderRadius,
                      ),
                    ),
                  ),
                  _ShimmerSection(
                    context,
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
                ],
              ),
            ),
            const SizedBox(
              width: Dimens.horizontal_margin,
            ),
            _ShimmerSection(
              context,
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
                  symbol: Icon(
                    Icons.monetization_on_outlined,
                    size: Dimens.large_text,
                    color: Theme.of(context).indicatorColor,
                  ),
                  child: _ShimmerSection(
                    context,
                    child: Container(
                      height: Dimens.medium_text,
                      width: 100,
                      margin: const EdgeInsets.symmetric(
                          vertical: Dimens.vertical_margin,
                          horizontal: Dimens.horizontal_margin),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: Dimens.kMaxBorderRadius,
                      ),
                    ),
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
                style: TextStyle(
                  fontSize: Dimens.lightly_medium_text,
                  color: Theme.of(context).indicatorColor,
                ),
              ),
            ],
          ),
        ),
        _ShimmerSection(
          context,
          child: Container(
            height: Dimens.medium_text,
            width: double.infinity,
            margin:
                const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: Dimens.kMaxBorderRadius,
            ),
          ),
        ),
        _ShimmerSection(
          context,
          child: Container(
            height: Dimens.medium_text * 6,
            width: double.infinity,
            margin:
                const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: Dimens.kMaxBorderRadius,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenteeInforSection(
    BuildContext context, {
    required RegisterInformation registerInformation,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInnerLineInfo(
          context,
          label: AppLocalizations.of(context).translate("name_label_translate"),
          data: registerInformation.name,
        ),
        _buildInnerLineInfo(
          context,
          label:
              AppLocalizations.of(context).translate("email_label_translate"),
          data: registerInformation.email,
        ),
        _buildOutterLineInfo(
          context,
          label: AppLocalizations.of(context)
              .translate("description_label_translate"),
          data: registerInformation.description,
        ),
        _buildOutterLineInfo(
          context,
          label: AppLocalizations.of(context).translate("note_label_translate"),
          data: registerInformation.note,
        ),
        _buildOutterLineInfo(
          context,
          label: AppLocalizations.of(context)
              .translate("expectation_label_translate"),
          data: registerInformation.expectation,
        ),
        _buildOutterLineInfo(
          context,
          label: AppLocalizations.of(context).translate("goal_label_translate"),
          data: registerInformation.goal,
        ),
      ],
    );
  }

  Widget _buildInnerLineInfo(BuildContext context,
      {required String label, required String data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).indicatorColor,
              fontSize: Dimens.small_text,
            ),
          ),
          Text(
            data,
            style: TextStyle(
              color: Theme.of(context).highlightColor,
              fontSize: Dimens.small_text,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutterLineInfo(BuildContext context,
      {required String label, required String data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).indicatorColor,
              fontSize: Dimens.small_text,
            ),
          ),
          const SizedBox(
            height: Dimens.vertical_margin,
          ),
          Row(
            children: [
              SizedBox(
                width: DeviceUtils.getScaledWidth(context, 0.1),
              ),
              Flexible(
                child: Text(
                  data,
                  softWrap: true,
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontSize: Dimens.small_text,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _ShimmerSection(BuildContext context, {required Widget child}) {
    return Shimmer.fromColors(
      child: child,
      baseColor: _themeStore.light.withOpacity(0.5),
      highlightColor: Theme.of(context).primaryColor,
      direction: ShimmerDirection.ltr,
      period: const Duration(milliseconds: 3000),
    );
  }
}
