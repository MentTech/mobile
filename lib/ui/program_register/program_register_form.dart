import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/stores/common/common_store.dart';
import 'package:mobile/stores/form/program_register_form_store.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:mobile/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class ProgramRegisterForm extends StatefulWidget {
  const ProgramRegisterForm({Key? key}) : super(key: key);

  @override
  State<ProgramRegisterForm> createState() => _ProgramRegisterFormState();
}

class _ProgramRegisterFormState extends State<ProgramRegisterForm> {
  //text controllers:-----------------------------------------------------------
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _expectationController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();

  final ThemeStore _themeStore = getIt<ThemeStore>();

  late final ProgramRegisterFormStore _formStore;

  @override
  void initState() {
    super.initState();

    _formStore = ProgramRegisterFormStore(
        Provider.of<CommonStore>(context, listen: false));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: GlassmorphismContainer(
          blur: Properties.blur_glass_morphism,
          opacity: Properties.opacity_glass_morphism,
          padding:
              const EdgeInsets.symmetric(vertical: Dimens.vertical_padding * 2),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimens.horizontal_padding * 2),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildName(),
            _buildEmail(),
            _buildDescription(),
            _buildNote(),
            _buildExpectation(),
            _buildGoal(),
          ],
        ),
      ),
    );
  }

  Widget _buildName() {
    return Container(
      alignment: Alignment.center,
      height: Dimens.text_field_height,
      child: Observer(
        builder: (_) {
          return TextFieldWidget(
            hint: AppLocalizations.of(context).translate('full_name'),
            inputType: TextInputType.text,
            iconData: Icons.person,
            iconColor: _themeStore.themeColor,
            textController: _nameController,
            inputAction: TextInputAction.done,
            autoFocus: false,
            onChanged: (value) {
              _formStore.setName(_nameController.text);
            },
            // onFieldSubmitted: (value) {
            //   FocusScope.of(context).requestFocus(_passwordFocusNode);
            // },
            errorText: _formStore.formErrorStore.name,
          );
        },
      ),
    );
  }

  Widget _buildEmail() {
    return Container(
      alignment: Alignment.center,
      height: Dimens.text_field_height,
      child: Observer(
        builder: (_) {
          return TextFieldWidget(
            hint: AppLocalizations.of(context).translate('email'),
            inputType: TextInputType.text,
            iconData: Icons.person,
            iconColor: _themeStore.themeColor,
            textController: _emailController,
            inputAction: TextInputAction.done,
            autoFocus: false,
            onChanged: (value) {
              _formStore.setEmail(_emailController.text);
            },
            // onFieldSubmitted: (value) {
            //   FocusScope.of(context).requestFocus(_passwordFocusNode);
            // },
            errorText: _formStore.formErrorStore.email,
          );
        },
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      alignment: Alignment.center,
      height: Dimens.text_field_height,
      child: Observer(
        builder: (_) {
          return TextFieldWidget(
            hint: AppLocalizations.of(context).translate('your_description'),
            inputType: TextInputType.text,
            iconData: Icons.person,
            iconColor: _themeStore.themeColor,
            textController: _descriptionController,
            inputAction: TextInputAction.done,
            autoFocus: false,
            onChanged: (value) {
              _formStore.setDescription(_descriptionController.text);
            },
            // onFieldSubmitted: (value) {
            //   FocusScope.of(context).requestFocus(_passwordFocusNode);
            // },
            errorText: _formStore.formErrorStore.description,
          );
        },
      ),
    );
  }

  Widget _buildNote() {
    return Container(
      alignment: Alignment.center,
      height: Dimens.text_field_height,
      child: Observer(
        builder: (_) {
          return TextFieldWidget(
            hint: AppLocalizations.of(context).translate('your_note'),
            inputType: TextInputType.text,
            iconData: Icons.person,
            iconColor: _themeStore.themeColor,
            textController: _noteController,
            inputAction: TextInputAction.done,
            autoFocus: false,
            onChanged: (value) {
              _formStore.setNote(_noteController.text);
            },
            // onFieldSubmitted: (value) {
            //   FocusScope.of(context).requestFocus(_passwordFocusNode);
            // },
            errorText: _formStore.formErrorStore.note,
          );
        },
      ),
    );
  }

  Widget _buildExpectation() {
    return Container(
      alignment: Alignment.center,
      height: Dimens.text_field_height,
      child: Observer(
        builder: (_) {
          return TextFieldWidget(
            hint: AppLocalizations.of(context).translate('your_expectation'),
            inputType: TextInputType.text,
            iconData: Icons.person,
            iconColor: _themeStore.themeColor,
            textController: _expectationController,
            inputAction: TextInputAction.done,
            autoFocus: false,
            onChanged: (value) {
              _formStore.setExpectation(_expectationController.text);
            },
            // onFieldSubmitted: (value) {
            //   FocusScope.of(context).requestFocus(_passwordFocusNode);
            // },
            errorText: _formStore.formErrorStore.expectation,
          );
        },
      ),
    );
  }

  Widget _buildGoal() {
    return Container(
      alignment: Alignment.center,
      height: Dimens.text_field_height,
      child: Observer(
        builder: (_) {
          return TextFieldWidget(
            hint: AppLocalizations.of(context).translate('your_goal'),
            inputType: TextInputType.text,
            iconData: Icons.person,
            iconColor: _themeStore.themeColor,
            textController: _goalController,
            inputAction: TextInputAction.done,
            autoFocus: false,
            onChanged: (value) {
              _formStore.setGoal(_goalController.text);
            },
            // onFieldSubmitted: (value) {
            //   FocusScope.of(context).requestFocus(_passwordFocusNode);
            // },
            errorText: _formStore.formErrorStore.goal,
          );
        },
      ),
    );
  }
}
