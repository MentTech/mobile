import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/mentor/mentor_store.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/ui/program_register/program_confirm.dart';
import 'package:mobile/ui/program_register/program_detail.dart';
import 'package:mobile/ui/program_register/program_register_form.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/widgets/background_colorful/linear_gradient_background.dart';
import 'package:mobile/widgets/shimmer_loading_effect/program_detail_shimmer.dart';
import 'package:provider/provider.dart';

class ProgramRegisterScreen extends StatelessWidget {
  ProgramRegisterScreen({Key? key}) : super(key: key);

  final ThemeStore _themeStore = getIt<ThemeStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Container(
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: const AssetImage(
          //         Assets.settingsBackgroundAssets,
          //       ),
          //       fit: BoxFit.fitHeight,
          //       opacity: _themeStore.opacityTheme,
          //     ),
          //   ),
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: Dimens.horizontal_padding,
          //   ),
          // ),
          LinearGradientBackground(
            colors: [
              _themeStore.themeColor,
              Color.alphaBlend(
                _themeStore.lightThemeColor.withOpacity(0.1),
                _themeStore.themeColor,
              ),
              Color.alphaBlend(
                _themeStore.lightThemeColor.withOpacity(0.3),
                _themeStore.themeColor,
              ),
            ],
            stops: const [0.0, 0.8, 1],
          ),
          IntroductionScreen(
            globalBackgroundColor: Colors.transparent,
            pages: [
              PageViewModel(
                titleWidget: const SizedBox(),
                bodyWidget: Observer(builder: (BuildContext _) {
                  MentorStore mentorStore =
                      Provider.of<MentorStore>(context, listen: false);

                  if (mentorStore.isLoading && !mentorStore.hasProgram) {
                    return const ProgramShimmerLoading();
                  } else {
                    return ProgramDetailContainer(
                      programDetail: mentorStore.getProgram!,
                      mentorModel: mentorStore.getMentor!,
                    );
                  }
                }),
              ),
              PageViewModel(
                titleWidget: const SizedBox(),
                bodyWidget: const ProgramRegisterForm(),
              ),
              PageViewModel(
                titleWidget: const SizedBox(),
                bodyWidget: const ProgramConfirmContainer(),
              ),
            ],
            done: const Text(
              "Confirm",
              style: TextStyle(
                color: Colors.white70,
                fontSize: Dimens.small_text,
              ),
            ),
            onDone: () {},
            showBackButton: true,
            back: const Text(
              "Previous",
              style: TextStyle(
                color: Colors.white70,
                fontSize: Dimens.small_text,
              ),
            ),
            showSkipButton: false,
            showNextButton: true,
            next: const Text(
              "Next",
              style: TextStyle(
                color: Colors.white70,
                fontSize: Dimens.small_text,
              ),
            ),
            dotsDecorator: DotsDecorator(
              color: _themeStore.themeColor,
              activeColor: _themeStore.lightThemeColor,
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
            animationDuration: 1000,
          ),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.only(right: Dimens.large_horizontal_margin),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    // clear data
                    // then
                    Routes.popRoute(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: Dimens.small_text,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
