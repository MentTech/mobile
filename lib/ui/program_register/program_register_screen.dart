import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mobile/constants/dimens.dart';

class ProgramRegisterScreen extends StatelessWidget {
  const ProgramRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: "Page 1",
            bodyWidget: Container(),
          ),
          PageViewModel(
            title: "Page 2",
            bodyWidget: Container(),
          ),
          PageViewModel(
            title: "Page 3",
            bodyWidget: Container(),
          ),
        ],
        done: const Text("Done"),
        onDone: () {},
        showBackButton: true,
        back: const Icon(Icons.arrow_back_ios_rounded),
        showSkipButton: false,
        showNextButton: true,
        next: const Text("Next"),
        dotsDecorator: DotsDecorator(
          color: Colors.orange,
          activeColor: Colors.blue,
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
    );
  }
}
