import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/common/common_store.dart';
import 'package:mobile/stores/form/program_register_form_store.dart';
import 'package:mobile/stores/mentor/mentor_store.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/ui/program_register/program_confirm.dart';
import 'package:mobile/ui/program_register/program_register_detail.dart';
import 'package:mobile/ui/program_register/program_register_form.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/widgets/background_colorful/linear_gradient_background.dart';
import 'package:mobile/widgets/progress_indicator_widget.dart';
import 'package:provider/provider.dart';

class ProgramRegisterScreen extends StatelessWidget {
  ProgramRegisterScreen({Key? key}) : super(key: key);

  final ThemeStore _themeStore = getIt<ThemeStore>();
  final ProgramRegisterFormStore _programRegisterFormStore =
      ProgramRegisterFormStore();

  @override
  Widget build(BuildContext context) {
    MentorStore mentorStore = Provider.of<MentorStore>(context, listen: false);
    CommonStore commonStore = Provider.of<CommonStore>(context, listen: false);
    UserStore userStore = Provider.of<UserStore>(context, listen: false);

    return Scaffold(
      body: Stack(
        children: [
          LinearGradientBackground(
            colors: _themeStore.lineToLineGradientColors,
            stops: null,
          ),
          Observer(
            builder: (_) {
              return IntroductionScreen(
                globalBackgroundColor: Colors.transparent,
                pages: [
                  PageViewModel(
                    useScrollView: true,
                    titleWidget: const SizedBox(),
                    bodyWidget: const ProgramRegisterDetail(),
                  ),
                  PageViewModel(
                    titleWidget: Text(
                      AppLocalizations.of(context)
                          .translate("fill_register_fields_note_translate"),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _themeStore.reverseThemeColor,
                        fontSize: Dimens.medium_text,
                      ),
                    ),
                    bodyWidget: ProgramRegisterForm(
                      programRegisterFormStore: _programRegisterFormStore,
                    ),
                  ),
                  PageViewModel(
                    titleWidget: const SizedBox(),
                    bodyWidget: ProgramConfirmContainer(
                      registerInformation:
                          _programRegisterFormStore.toRegisterInforObject(),
                      mentorModel: mentorStore.mentorModel!,
                      program: mentorStore.program,
                    ),
                  ),
                ],
                done: Text(
                  AppLocalizations.of(context)
                      .translate("confirm_button_translate"),
                  style: TextStyle(
                    color: _themeStore.reverseThemeColor,
                    fontSize: Dimens.small_text,
                  ),
                ),
                showBackButton: true,
                back: Text(
                  AppLocalizations.of(context)
                      .translate("previous_button_translate"),
                  style: TextStyle(
                    color: _themeStore.reverseThemeColor,
                    fontSize: Dimens.small_text,
                  ),
                ),
                showSkipButton: false,
                showNextButton: ((mentorStore.hasProgram &&
                        userStore.user!.coin > mentorStore.program!.credit) &&
                    (!_programRegisterFormStore.onPage ||
                        _programRegisterFormStore.canRegisterProgram)),
                next: Text(
                  AppLocalizations.of(context)
                      .translate("next_button_translate"),
                  style: TextStyle(
                    color: _themeStore.reverseThemeColor,
                    fontSize: Dimens.small_text,
                  ),
                ),
                dotsDecorator: DotsDecorator(
                  color: _themeStore.reverseThemeColor,
                  activeColor: _themeStore.reverseThemeColorfulColor,
                  size: const Size(10, 10),
                  activeSize: const Size(15, 10),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: Dimens.kBorderRadius,
                  ),
                ),
                isTopSafeArea: true,
                isBottomSafeArea: true,
                isProgress: true,
                isProgressTap: false,
                freeze: true,
                animationDuration: 500,
                onChange: (int pageIndex) {
                  _programRegisterFormStore.onPage = pageIndex == 1;
                },
                onDone: () {
                  commonStore.registerProgramOfMentor(
                      mentorID: mentorStore.mentorModel!.id,
                      programID: mentorStore.program!.id,
                      body: _programRegisterFormStore.toRequestJson());
                },
              );
            },
          ),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.only(right: Dimens.large_horizontal_margin),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    Routes.popRoute(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)
                        .translate("cancel_button_translate"),
                    style: TextStyle(
                      fontSize: Dimens.small_text,
                      color: Colors.red.shade300,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Observer(
            builder: (context) {
              // if (commonStore.isRegisteringDone) {
              //   WidgetsBinding.instance.addPostFrameCallback((_) {
              //     FlushbarHelper.createSuccess(
              //       message: AppLocalizations.of(context)
              //           .translate("register_session_status_success"),
              //       title:
              //           AppLocalizations.of(context).translate('home_tv_error'),
              //       duration:
              //           const Duration(seconds: Properties.delayTimeInSecond),
              //     ).show(context);
              //   });
              // }
              return Visibility(
                visible: commonStore.isRegistering,
                child: CustomProgressIndicatorWidget(),
              );
            },
          ),
          // Observer(
          //   // validator
          //   builder: (_) {
          //     return commonStore.isRegisteringDone
          //         ? _showSuccessMessage(
          //             context,
          //             AppLocalizations.of(context)
          //                 .translate("register_session_status_success"))
          //         : const SizedBox.shrink();
          //   },
          // ),
        ],
      ),
    );
  }
}
