import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';

class CustomInStackAppBar extends StatelessWidget {
  const CustomInStackAppBar({
    Key? key,
    required this.nameAppbar,
  }) : super(key: key);

  final String nameAppbar;

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
                color: Theme.of(context).indicatorColor,
              ),
            ),
            Text(
              nameAppbar,
              style: TextStyle(
                fontSize: Dimens.medium_text,
                color: Theme.of(context).indicatorColor,
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
