import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/data/repository.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/order/order_store.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/background_colorful/linear_gradient_background.dart';
import 'package:mobile/utils/extension/int_extension.dart';
import 'package:mobile/widgets/progress_indicator_widget.dart';

class DepositToken extends StatefulWidget {
  const DepositToken({Key? key}) : super(key: key);

  @override
  State<DepositToken> createState() => _DepositTokenState();
}

class _DepositTokenState extends State<DepositToken> {
  //text controllers:-----------------------------------------------------------
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _tokenNumberController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  //stores:---------------------------------------------------------------------
  final OrderStore _orderStore = OrderStore(getIt<Repository>());
  final ThemeStore _themeStore = getIt<ThemeStore>();

  // attributes:----------------------------------------------------------------

  // init:----------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _emailController.dispose();
    _nameController.dispose();
    _tokenNumberController.dispose();
    _noteController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LinearGradientBackground(
            colors: _themeStore.lineToLineGradientColors,
            stops: null,
          ),
          // build appbar
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.horizontal_padding,
                  vertical: Dimens.vertical_padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildLoadTokenMethod(),
                  _buildLoadTokenForm(),
                ],
              ),
            ),
          ),

          Observer(
            builder: (context) {
              return Visibility(
                visible: _orderStore.isLoading,
                child: CustomProgressIndicatorWidget(),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildLoadTokenMethod() {
    return Column(
      children: [
        Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: Dimens.vertical_space,
            runSpacing: Dimens.horizontal_space,
            direction: Axis.horizontal,
            children: []),
        Container(
          margin: const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
          child: Observer(
            builder: (_) {
              return RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: _orderStore.rateTopup.toTokenValueString(
                              locale: AppLocalizations.of(context)
                                  .locale
                                  .languageCode) +
                          " = 10.000 VNĐ\n",
                      style: TextStyle(
                        color: _themeStore.reverseThemeColor,
                        fontSize: Dimens.lightly_medium_text,
                      ),
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)
                          .translate("deposit_rule"),
                      style: TextStyle(
                        color: _themeStore.reverseThemeColor,
                        fontSize: Dimens.small_text,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLoadTokenForm() {
    return Column(
      children: [],
    );
  }
}
