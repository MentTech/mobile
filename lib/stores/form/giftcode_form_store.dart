import 'package:mobx/mobx.dart';

part 'giftcode_form_store.g.dart';

class GiftcodeFormStore = _GiftcodeFormStore with _$GiftcodeFormStore;

abstract class _GiftcodeFormStore with Store {
  // store for handling form errors
  final GiftcodeErrorForm formErrorStore = GiftcodeErrorForm();

  _GiftcodeFormStore() {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => giftcode, validateGiftcode),
    ];
  }

  // store variables:-----------------------------------------------------------

  @observable
  String giftcode = '';

  @computed
  bool get canApplyGiftcode =>
      !formErrorStore.hasErrorsApply && giftcode.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void setApplyGiftcode(String value) {
    giftcode = value;
  }

  @action
  void validateGiftcode(String value) {
    if (value.isEmpty) {
      formErrorStore.giftcode = "Giftcode can't be empty";
    } else if (value.length < 15) {
      formErrorStore.giftcode = "Giftcode is to short";
    } else {
      formErrorStore.giftcode = null;
    }
  }

  // general methods:-----------------------------------------------------------
  Map<String, String> toRequestJson() {
    return {
      "code": giftcode,
    };
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validateGiftcode(giftcode);
  }
}

class GiftcodeErrorForm = _GiftcodeErrorForm with _$GiftcodeErrorForm;

abstract class _GiftcodeErrorForm with Store {
  @observable
  String? giftcode;

  @computed
  bool get hasErrorsApply => giftcode != null;
  //  || note != null;
}
