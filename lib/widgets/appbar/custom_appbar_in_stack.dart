import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';

class CustomInStackAppBar extends StatelessWidget {
  const CustomInStackAppBar({
    Key? key,
    required this.nameAppbar,
    this.customColor,
  }) : super(key: key);

  final String nameAppbar;
  final Color? customColor;

  @override
  Widget build(BuildContext context) {
    return GlassmorphismContainer(
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Routes.popRoute(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: customColor ?? Theme.of(context).indicatorColor,
              ),
            ),
            Flexible(
              child: Text(
                nameAppbar,
                softWrap: true,
                style: TextStyle(
                  fontSize: Dimens.medium_text,
                  color: customColor ?? Theme.of(context).indicatorColor,
                ),
              ),
            ),
          ],
        ),
      ),
      blur: Properties.blur_glass_morphism,
      opacity: Properties.opacity_glass_morphism,
      radius: Dimens.kBorderRadiusValue,
    );
  }
}
