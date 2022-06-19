import 'package:flutter/material.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';

class CustomProgressIndicatorWidget extends StatelessWidget {
  CustomProgressIndicatorWidget({
    Key? key,
  }) : super(key: key);

  final ThemeStore _themeStore = getIt<ThemeStore>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 100,
        constraints: const BoxConstraints.expand(),
        child: FittedBox(
          fit: BoxFit.none,
          child: SizedBox(
            height: 100,
            width: 100,
            child: GlassmorphismContainer(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: CircularProgressIndicator(
                  color: _themeStore.reverseThemeColorfulColor,
                  backgroundColor: Colors.transparent,
                ),
              ),
              blur: Properties.blur_glass_morphism,
              opacity: Properties.opacity_glass_morphism,
            ),
          ),
        ),
        decoration:
            const BoxDecoration(color: Color.fromARGB(100, 105, 105, 105)),
      ),
    );
  }
}
