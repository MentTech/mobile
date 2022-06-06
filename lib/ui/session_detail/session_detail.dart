import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/common/session/session.dart';
import 'package:mobile/stores/common/common_store.dart';
import 'package:mobile/stores/mentor/mentor_store.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/ui/program_register/program_detail.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/background_colorful/linear_gradient_background.dart';
import 'package:mobile/widgets/glassmorphism_widgets/glassmorphism_text_button.dart';
import 'package:provider/provider.dart';

class SesstionDetail extends StatelessWidget {
  SesstionDetail({
    Key? key,
    required this.session,
    this.callback,
  }) : super(key: key);

  final ThemeStore _themeStore = getIt<ThemeStore>();

  final Session session;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    final MentorStore mentorStore =
        Provider.of<MentorStore>(context, listen: false);

    final CommonStore commonStore =
        Provider.of<CommonStore>(context, listen: false);
    commonStore.setSessionObserver(session);

    return Scaffold(
      body: Stack(
        children: [
          LinearGradientBackground(
            colors: [
              _themeStore.themeColor,
              Colors.black
                  .withGreen((_themeStore.themeColor.green * 0.7).round())
                  .withBlue((_themeStore.themeColor.blue * 0.7).round()),
              Colors.black
                  .withGreen((_themeStore.themeColor.green * 0.35).round())
                  .withBlue((_themeStore.themeColor.blue * 0.35).round()),
            ],
            stops: const [0, 0.35, 0.7],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.horizontal_padding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Observer(
                      builder: (context) {
                        mentorStore.fetchAMentor(session.program.mentorId);
                        return ProgramDetailContainer(
                          programDetail: session.program,
                          mentorModel: mentorStore.getMentor,
                        );
                      },
                    ),
                  ),
                  Observer(
                    builder: (context) {
                      Session observerSession = commonStore.sessionObserver!;
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          observerSession.isAccepted
                              ? const SizedBox()
                              : GlassmorphismTextButton(
                                  alignment: Alignment.center,
                                  text: AppLocalizations.of(context)
                                      .translate("mark_as_done_translate"),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Dimens.small_vertical_padding,
                                  ),
                                  textColor: Colors.white70,
                                  blur: Properties.blur_glass_morphism,
                                  opacity: Properties.opacity_glass_morphism,
                                  onTap: () {
                                    commonStore.markSessionOfProgramAsDone();
                                  },
                                ),
                          observerSession.done
                              ? const SizedBox()
                              : GlassmorphismTextButton(
                                  alignment: Alignment.center,
                                  text: AppLocalizations.of(context).translate(
                                      "review_about_session_translate"),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Dimens.small_vertical_padding,
                                  ),
                                  textColor: Colors.white70,
                                  blur: Properties.blur_glass_morphism,
                                  opacity: Properties.opacity_glass_morphism,
                                  onTap: () {
                                    // show popup and then call api
                                    // commonStore.reviewSessionOfProgram();
                                  },
                                ),
                          observerSession.isCanceled
                              ? const SizedBox()
                              : GlassmorphismTextButton(
                                  alignment: Alignment.center,
                                  text: AppLocalizations.of(context)
                                      .translate("unregister_translate"),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Dimens.small_vertical_padding,
                                  ),
                                  textColor: Colors.white70,
                                  blur: Properties.blur_glass_morphism,
                                  opacity: Properties.opacity_glass_morphism,
                                  onTap: () {
                                    // show popup and then call api
                                    // commonStore.unregisterSessionOfProgram();
                                  },
                                ),
                        ],
                      );
                    },
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
