import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/colors.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/widgets/background_colorful/linear_gradient_background.dart';
import 'package:mobile/widgets/background_colorful/random_bubble_gradient_background.dart';
import 'package:mobile/widgets/button_widgets/neumorphism_button.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatelessWidget {
  UserProfile({Key? key}) : super(key: key);

  final ThemeStore themeStore = getIt<ThemeStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const LinearGradientBackground(),
          RandomBubbleGradientBackground(
            count: 3,
            maxRadius: 150,
            minRadius: 50,
            gradientColor: [
              AppColors.lightBlueContrast.withOpacity(0.1),
              AppColors.darkBlueContrast,
            ],
          ),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: Dimens.vertical_padding),
              child: Observer(
                builder: (context) {
                  final UserStore userStore =
                      Provider.of<UserStore>(context, listen: false);

                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: NeumorphismButton(
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.darkBlue[700],
                          ),
                          onTap: () {
                            Routes.popRoute(context);
                          },
                        ),
                        title: Text(
                          userStore.user!.name,
                          style: TextStyle(
                            color: themeStore.textTitleColor,
                            fontSize: Dimens.medium_text,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                          ),
                        ),
                        subtitle: Text("id: ${userStore.user!.id}"),
                        trailing: NeumorphismButton(
                          child: Icon(
                            Icons.edit,
                            color: AppColors.darkBlue[700],
                          ),
                          shape: BoxShape.circle,
                          onTap: () {},
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
