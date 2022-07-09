import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/assets.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/data/repository.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/user/user.dart';
import 'package:mobile/stores/enum/payment_method.dart';
import 'package:mobile/stores/form/deposit_token_form_store.dart';
import 'package:mobile/stores/order/order_store.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/ui/more_token/deposit_token_successful.dart';
import 'package:mobile/utils/application/application_utils.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/utils/extension/int_extension.dart';
import 'package:mobile/widgets/glassmorphism_widgets/glassmorphism_widget_button.dart';
import 'package:mobile/widgets/progress_indicator_widget.dart';
import 'package:mobile/widgets/template/glassmorphism_appbar_only.dart';
import 'package:mobile/widgets/textfield/textfield_name_before.dart';
import 'package:provider/provider.dart';

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
  // final TextEditingController _noteController = TextEditingController();

  //stores:---------------------------------------------------------------------
  final OrderStore _orderStore = OrderStore(getIt<Repository>());
  final DepositTokenFormStore _depositTokenFormStore = DepositTokenFormStore();

  // attributes:----------------------------------------------------------------
  late double edgeDimensPaymentMethod;
  late double iconLogoEdgeDimens;

  // init:----------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    edgeDimensPaymentMethod = DeviceUtils.getScaledWidth(context, 0.28);
    iconLogoEdgeDimens = edgeDimensPaymentMethod * 0.5;

    UserModel userModel = Provider.of<UserStore>(context).user!;

    _emailController.text = userModel.email;
    _depositTokenFormStore.setEmail(userModel.email);

    _nameController.text = userModel.name;
    _depositTokenFormStore.setName(userModel.name);
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _emailController.dispose();
    _nameController.dispose();
    _tokenNumberController.dispose();
    // _noteController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlassmorphismGradientScaffoldAppbar(
      safeAreaTop: true,
      appbarName: AppLocalizations.of(context).translate("deposit_title"),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimens.horizontal_padding,
            vertical: Dimens.vertical_padding),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(
                      height: kBottomNavigationBarHeight,
                    ),
                    _buildLoadTokenMethod(),
                    _buildLoadTokenForm(),
                    const SizedBox(
                      height: kBottomNavigationBarHeight,
                    ),
                  ],
                ),
              ),
            ),
            _buildPayUpButton(),
          ],
        ),
      ),
      progressIndicator: Observer(
        builder: (context) {
          return Visibility(
            visible: _orderStore.isLoading,
            child: const CustomProgressIndicatorWidget(),
          );
        },
      ),
      messageNotification: Observer(
        // validator
        builder: (_) {
          return _orderStore.isSuccess
              ? ApplicationUtils.showSuccessMessage(
                  context,
                  "transaction_notification_title_translate",
                  _orderStore.getSuccessMessageKey,
                  callback: (() {
                    Routes.route(context, DepositTokenSuccessFul());
                  }),
                )
              : ApplicationUtils.showErrorMessage(
                  context,
                  "transaction_notification_title_translate",
                  _orderStore.getFailedMessageKey,
                );
        },
      ),
    );
  }

  Widget _buildPayUpButton() {
    return Container(
      margin:
          const EdgeInsets.symmetric(vertical: Dimens.large_vertical_margin),
      child: GlassmorphismWidgetButton(
        radius: Dimens.kBorderRadiusValue,
        child: TextButton(
          onPressed: () {
            _depositTokenFormStore.validateAll();
            if (_depositTokenFormStore.canLoadToken) {
              _orderStore.orderATopup(
                  orderInfor: _depositTokenFormStore.toRequestJson());
            }
          },
          child: Text(
            AppLocalizations.of(context).translate("payup_button_translate"),
            style: TextStyle(
              color: Theme.of(context).indicatorColor,
              fontSize: Dimens.lightly_medium_text,
            ),
          ),
        ),
        blur: Properties.blur_glass_morphism,
        opacity: Properties.opacity_glass_morphism,
      ),
    );
  }

  Widget _buildLoadTokenMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildPaymentMethods(),
        _buildRateTokenCurrency(),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Observer(builder: (_) {
        return Row(
          children: [
            // PaymentMethodSelectableButton(
            //   icon: Image.asset(
            //     Assets.paymentMethodPaypal,
            //     alignment: Alignment.center,
            //     fit: BoxFit.contain,
            //     height: iconLogoEdgeDimens,
            //   ),
            //   value: PaymentMethod.Paypal.name,
            //   edgeDimens: edgeDimensPaymentMethod,
            //   isSelected: _depositTokenFormStore
            //       .isSamePaymentMethod(PaymentMethod.Paypal),
            //   onTap: () {
            //     _depositTokenFormStore.setPaymentMethod(PaymentMethod.Paypal);
            //   },
            // ),
            PaymentMethodSelectableButton(
              icon: Icon(
                Icons.account_balance_rounded,
                color: Theme.of(context).selectedRowColor,
                size: Dimens.ultra_large_text,
              ),
              value: AppLocalizations.of(context)
                  .translate("wiretransfer_label_translate"),
              edgeDimens: edgeDimensPaymentMethod,
              isSelected: _depositTokenFormStore
                  .isSamePaymentMethod(PaymentMethod.WireTransfer),
              onTap: () {
                _depositTokenFormStore
                    .setPaymentMethod(PaymentMethod.WireTransfer);
              },
            ),
            PaymentMethodSelectableButton(
              icon: Image.asset(
                Assets.paymentMethodMomo,
                alignment: Alignment.center,
                fit: BoxFit.contain,
                height: iconLogoEdgeDimens,
              ),
              value: PaymentMethod.Momo.name,
              edgeDimens: edgeDimensPaymentMethod,
              isSelected: _depositTokenFormStore
                  .isSamePaymentMethod(PaymentMethod.Momo),
              onTap: () {
                _depositTokenFormStore.setPaymentMethod(PaymentMethod.Momo);
              },
            ),
            PaymentMethodSelectableButton(
              icon: Image.asset(
                Assets.paymentMethodViettelPay,
                alignment: Alignment.center,
                fit: BoxFit.contain,
                height: iconLogoEdgeDimens,
              ),
              value: PaymentMethod.ViettelPay.name,
              edgeDimens: edgeDimensPaymentMethod,
              isSelected: _depositTokenFormStore
                  .isSamePaymentMethod(PaymentMethod.ViettelPay),
              onTap: () {
                _depositTokenFormStore
                    .setPaymentMethod(PaymentMethod.ViettelPay);
              },
            ),
            PaymentMethodSelectableButton(
              icon: Image.asset(
                Assets.paymentMethodZaloPay,
                alignment: Alignment.center,
                fit: BoxFit.contain,
                height: iconLogoEdgeDimens,
              ),
              value: PaymentMethod.ZaloPay.name,
              edgeDimens: edgeDimensPaymentMethod,
              isSelected: _depositTokenFormStore
                  .isSamePaymentMethod(PaymentMethod.ZaloPay),
              onTap: () {
                _depositTokenFormStore.setPaymentMethod(PaymentMethod.ZaloPay);
              },
            ),
          ],
        );
      }),
    );
  }

  Container _buildRateTokenCurrency() {
    return Container(
      margin:
          const EdgeInsets.symmetric(vertical: Dimens.large_vertical_margin),
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
                    color: Theme.of(context).indicatorColor,
                    fontSize: Dimens.lightly_medium_text,
                    height: 1.5,
                  ),
                ),
                TextSpan(
                  text: AppLocalizations.of(context).translate("deposit_rule") +
                      _orderStore.rateTopup.toString(),
                  style: TextStyle(
                    color: Theme.of(context).indicatorColor,
                    fontSize: Dimens.small_text,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadTokenForm() {
    return Column(
      children: [
        _buildEmaildField(),
        _buildNameField(),
        _buildTokenField(),
        // _buildNoteField(),
      ],
    );
  }

  Widget _buildEmaildField() {
    return Observer(
      builder: (_) {
        return TextFieldNameWidget(
          frontFlex: 3,
          backFlex: 19,
          labelText:
              AppLocalizations.of(context).translate("email_label_translate"),
          errorText: _depositTokenFormStore.formErrorStore.email,
          controller: _emailController,
          textColor: Theme.of(context).indicatorColor,
          onValueChanged: (value) {
            _depositTokenFormStore.setEmail(_emailController.text);
          },
        );
      },
    );
  }

  Widget _buildNameField() {
    return Observer(
      builder: (_) {
        return TextFieldNameWidget(
          frontFlex: 3,
          backFlex: 19,
          labelText:
              AppLocalizations.of(context).translate("name_label_translate"),
          errorText: _depositTokenFormStore.formErrorStore.name,
          controller: _nameController,
          textColor: Theme.of(context).indicatorColor,
          onValueChanged: (value) {
            _depositTokenFormStore.setName(_nameController.text);
          },
        );
      },
    );
  }

  Widget _buildTokenField() {
    return Observer(
      builder: (_) {
        return TextFieldNameWidget(
          frontFlex: 3,
          backFlex: 19,
          labelText:
              AppLocalizations.of(context).translate("token_label_translate"),
          errorText: _depositTokenFormStore.formErrorStore.token,
          controller: _tokenNumberController,
          textColor: Theme.of(context).indicatorColor,
          onValueChanged: (value) {
            _depositTokenFormStore.setToken(_tokenNumberController.text);
          },
        );
      },
    );
  }

  // Widget _buildNoteField() {
  //   return Observer(
  //     builder: (_) {
  //       return TextFieldNameWidget(
  //         labelText:
  //             AppLocalizations.of(context).translate("note_label_translate"),
  //         errorText: _depositTokenFormStore.formErrorStore.note,
  //         controller: _noteController,
  //         textColor: Theme.of(context).indicatorColor,
  //         onValueChanged: (value) {
  //           _depositTokenFormStore.setNote(_noteController.text);
  //         },
  //       );
  //     },
  //   );
  // }

  // General Methods:-----------------------------------------------------------

}

class PaymentMethodSelectableButton extends StatelessWidget {
  const PaymentMethodSelectableButton({
    Key? key,
    required this.icon,
    required this.value,
    required this.isSelected,
    required this.onTap,
    required this.edgeDimens,
  }) : super(key: key);

  final Widget icon;
  final String value;
  final VoidCallback onTap;
  final bool isSelected;
  final double edgeDimens;

  @override
  Widget build(BuildContext context) {
    final Color statusColor = isSelected
        ? Theme.of(context).selectedRowColor
        : Color.alphaBlend(
            Theme.of(context).indicatorColor.withOpacity(0.2),
            Colors.white70,
          );
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimens.horizontal_margin),
      height: edgeDimens,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: GlassmorphismWidgetButton(
          background: statusColor,
          radius: 10,
          padding: const EdgeInsets.symmetric(
            vertical: Dimens.small_vertical_padding,
            horizontal: Dimens.small_horizontal_padding,
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              icon,
              Text(
                value,
                softWrap: true,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: isSelected
                          ? Theme.of(context).selectedRowColor
                          : Theme.of(context).primaryColorLight,
                    ),
              ),
            ],
          ),
          onTap: onTap,
          blur: Properties.blur_glass_morphism,
          opacity: Properties.opacity_glass_morphism,
        ),
      ),
    );
  }
}
