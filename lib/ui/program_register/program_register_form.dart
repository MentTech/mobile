import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/stores/form/program_register_form_store.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:mobile/widgets/textfield/textfield_widget.dart';

class ProgramRegisterForm extends StatefulWidget {
  const ProgramRegisterForm({
    Key? key,
    required this.programRegisterFormStore,
  }) : super(key: key);

  final ProgramRegisterFormStore programRegisterFormStore;

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

  late final ProgramRegisterFormStore _formStore;

  @override
  void initState() {
    super.initState();

    _formStore = widget.programRegisterFormStore;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
        child: Center(
          child: GlassmorphismContainer(
            blur: Properties.blur_glass_morphism,
            opacity: Properties.opacity_glass_morphism,
            padding: const EdgeInsets.symmetric(
                vertical: Dimens.vertical_padding * 2),
            child: _buildContent(),
          ),
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
      margin: const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
      child: Observer(
        builder: (_) {
          return TextFieldWidget(
            hint: AppLocalizations.of(context).translate('full_name'),
            inputType: TextInputType.text,
            iconData: Icons.person,
            textController: _nameController,
            inputAction: TextInputAction.done,
            autoFocus: false,
            onChanged: (value) {
              _formStore.setName(_nameController.text);
            },
            errorText: _formStore.formErrorStore.name,
          );
        },
      ),
    );
  }

  Widget _buildEmail() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
      child: Observer(
        builder: (_) {
          return TextFieldWidget(
            hint: AppLocalizations.of(context).translate('email'),
            inputType: TextInputType.text,
            iconData: Icons.email_rounded,
            textController: _emailController,
            inputAction: TextInputAction.done,
            autoFocus: false,
            onChanged: (value) {
              _formStore.setEmail(_emailController.text);
            },
            errorText: _formStore.formErrorStore.email,
          );
        },
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
      child: Observer(
        builder: (_) {
          return TextFieldWidget(
            hint: AppLocalizations.of(context).translate('your_description'),
            inputType: TextInputType.text,
            iconData: Icons.badge_rounded,
            textController: _descriptionController,
            inputAction: TextInputAction.done,
            autoFocus: false,
            numberLines: 3,
            onChanged: (value) {
              _formStore.setDescription(_descriptionController.text);
            },
            errorText: _formStore.formErrorStore.description,
          );
        },
      ),
    );
  }

  Widget _buildNote() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
      child: Observer(
        builder: (_) {
          return TextFieldWidget(
            hint: AppLocalizations.of(context).translate('your_note'),
            inputType: TextInputType.text,
            iconData: Icons.sticky_note_2_rounded,
            textController: _noteController,
            inputAction: TextInputAction.done,
            autoFocus: false,
            numberLines: 3,
            onChanged: (value) {
              _formStore.setNote(_noteController.text);
            },
            errorText: _formStore.formErrorStore.note,
          );
        },
      ),
    );
  }

  Widget _buildExpectation() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
      child: Observer(
        builder: (_) {
          return TextFieldWidget(
            hint: AppLocalizations.of(context).translate('your_expectation'),
            inputType: TextInputType.text,
            iconData: Icons.wysiwyg_rounded,
            textController: _expectationController,
            inputAction: TextInputAction.done,
            autoFocus: false,
            numberLines: 3,
            onChanged: (value) {
              _formStore.setExpectation(_expectationController.text);
            },
            errorText: _formStore.formErrorStore.expectation,
          );
        },
      ),
    );
  }

  Widget _buildGoal() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Dimens.vertical_margin),
      child: Observer(
        builder: (_) {
          return TextFieldWidget(
            hint: AppLocalizations.of(context).translate('your_goal'),
            inputType: TextInputType.text,
            iconData: Icons.flag_rounded,
            textController: _goalController,
            inputAction: TextInputAction.done,
            autoFocus: false,
            numberLines: 3,
            onChanged: (value) {
              _formStore.setGoal(_goalController.text);
            },
            errorText: _formStore.formErrorStore.goal,
          );
        },
      ),
    );
  }
}
