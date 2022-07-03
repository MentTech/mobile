import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/common/session/session.dart';
import 'package:mobile/stores/common/common_store.dart';
import 'package:mobile/stores/mentor/mentor_store.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/ui/session_detail/program_detail.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/background_colorful/linear_gradient_background.dart';
import 'package:mobile/widgets/dialog_showing/slider_dialog.dart';
import 'package:mobile/widgets/glassmorphism_widgets/glassmorphism_text_button.dart';
import 'package:mobile/widgets/popup_template/field_popup.dart';
import 'package:mobile/widgets/popup_template/yes_no_popup.dart';
import 'package:mobile/widgets/progress_indicator_widget.dart';
import 'package:mobile/widgets/star_widget/rate_review.dart';
import 'package:provider/provider.dart';

class SesstionDetail extends StatefulWidget {
  const SesstionDetail({
    Key? key,
    required this.session,
    this.callback,
  }) : super(key: key);

  final Session session;
  final VoidCallback? callback;

  @override
  State<SesstionDetail> createState() => _SesstionDetailState();
}

class _SesstionDetailState extends State<SesstionDetail> {
  // stored:--------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();
  late final MentorStore _mentorStore;
  late final CommonStore _commonStore;

  // text controller:-----------------------------------------------------------
  final TextEditingController commentReview = TextEditingController();

  // state variable:------------------------------------------------------------
  int rate = 0;

  @override
  void initState() {
    super.initState();

    _mentorStore = Provider.of<MentorStore>(context, listen: false);

    _mentorStore.fetchAMentor(widget.session.program.mentorId);

    _commonStore = Provider.of<CommonStore>(context, listen: false);
    _commonStore.setSessionObserver(widget.session);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          LinearGradientBackground(
            colors: _themeStore.lineToLineGradientColors,
            stops: null,
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Observer(
                    builder: (context) {
                      if (!_mentorStore.hasMentor) {
                        _mentorStore
                            .fetchAMentor(widget.session.program.mentorId);
                      }
                      return ProgramDetailContainer(
                        programDetail: widget.session.program,
                        mentorModel: _mentorStore.getMentor,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: Dimens.medium_vertical_margin,
                ),
                _buildActionMethod(),
                const SizedBox(
                  height: Dimens.extra_large_vertical_margin,
                ),
              ],
            ),
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _commonStore.isLoading,
                child: const CustomProgressIndicatorWidget(),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildActionMethod() {
    return Observer(
      builder: (context) {
        Session observerSession = _commonStore.sessionObserver!;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            observerSession.isCanceled
                ? const SizedBox()
                : observerSession.done
                    ? GlassmorphismTextButton(
                        alignment: Alignment.center,
                        text: AppLocalizations.of(context)
                            .translate("review_about_session_translate"),
                        padding: const EdgeInsets.symmetric(
                          vertical: Dimens.small_vertical_padding,
                          horizontal: Dimens.horizontal_padding,
                        ),
                        textColor: Colors.white70,
                        blur: Properties.blur_glass_morphism,
                        opacity: Properties.opacity_glass_morphism,
                        onTap: () {
                          DialogPopupPresenter.showSlidePopupDialog<bool>(
                            context,
                            _buildReviewPopup(),
                            400,
                            300,
                            blur: Properties.lightly_blur_glass_morphism,
                            opacity: Properties.lightly_opacity_glass_morphism,
                          ).then(
                            (bool? isSend) {
                              if (isSend ?? false) {
                                _commonStore.reviewSessionOfProgram(
                                  ReviewModel(
                                    rate: rate,
                                    comment: commentReview.text,
                                  ),
                                );
                              }
                            },
                          );
                        },
                      )
                    : observerSession.isAccepted
                        ? GlassmorphismTextButton(
                            alignment: Alignment.center,
                            text: AppLocalizations.of(context)
                                .translate("mark_as_done_translate"),
                            padding: const EdgeInsets.symmetric(
                              vertical: Dimens.small_vertical_padding,
                              horizontal: Dimens.horizontal_padding,
                            ),
                            textColor: Colors.white70,
                            blur: Properties.blur_glass_morphism,
                            opacity: Properties.opacity_glass_morphism,
                            onTap: () {
                              DialogPopupPresenter.showSlidePopupDialog<bool>(
                                context,
                                _buildMarkDonePopup(),
                                150,
                                300,
                                blur: Properties.lightly_blur_glass_morphism,
                                opacity:
                                    Properties.lightly_opacity_glass_morphism,
                              ).then(
                                (bool? isSend) {
                                  if (isSend ?? false) {
                                    _commonStore.markSessionOfProgramAsDone();
                                  }
                                },
                              );
                            },
                          )
                        : GlassmorphismTextButton(
                            alignment: Alignment.center,
                            text: AppLocalizations.of(context)
                                .translate("unregister_translate"),
                            padding: const EdgeInsets.symmetric(
                              vertical: Dimens.small_vertical_padding,
                              horizontal: Dimens.horizontal_padding,
                            ),
                            textColor: Colors.white70,
                            blur: Properties.blur_glass_morphism,
                            opacity: Properties.opacity_glass_morphism,
                            onTap: () {
                              DialogPopupPresenter.showSlidePopupDialog<bool>(
                                context,
                                _buildUnregisterPopup(),
                                150,
                                300,
                                blur: Properties.lightly_blur_glass_morphism,
                                opacity:
                                    Properties.lightly_opacity_glass_morphism,
                              ).then(
                                (bool? isSend) {
                                  if (isSend ?? false) {
                                    _commonStore.unregisterSessionOfProgram();
                                  }
                                },
                              );
                            },
                          ),
          ],
        );
      },
    );
  }

  Widget _buildReviewPopup() {
    return FieldPopupTemplate(
      title: AppLocalizations.of(context).translate("review_title"),
      middleChild: RateReview(
        rate: rate,
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.large_horizontal_padding,
        ),
        onReviewChange: (int rate) {
          this.rate = rate;
        },
      ),
      fieldContents: [
        TextFieldContent(
          isObscure: false,
          textEditingController: commentReview,
          textInputType: TextInputType.multiline,
          hint: AppLocalizations.of(context).translate("your_review"),
          numberLines: 10,
        ),
      ],
    );
  }

  Widget _buildMarkDonePopup() {
    return YesNoPopup(
      child: ListTile(
        title: Text(
          AppLocalizations.of(context).translate("mark_session_as_done"),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          AppLocalizations.of(context).translate("want_to_change_question"),
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),
      ),
    );
  }

  Widget _buildUnregisterPopup() {
    return YesNoPopup(
      child: ListTile(
        title: Text(
          AppLocalizations.of(context).translate("unregister_session"),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        subtitle: Text(
          AppLocalizations.of(context).translate("want_to_change_question"),
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
