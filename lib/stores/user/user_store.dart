import 'package:mobile/data/repository.dart';
import 'package:mobile/models/user/user.dart';
import 'package:mobile/stores/form/form_store.dart';
import 'package:mobile/stores/message/message_store.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  // repository instance
  final Repository _repository;

  // store for handling form errors
  final FormErrorStore formErrorStore = FormErrorStore();

  // store for handling error messages
  final MessageStore messageStore = MessageStore();

  // token for access
  String? accessToken;

  // constructor:---------------------------------------------------------------
  _UserStore(Repository repository) : _repository = repository {
    // setting up disposers
    _setupDisposers();

    // checking if user is logged in
    // repository.authToken.then((value) {
    //   accessToken = value;
    // });
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
      reaction((_) => accessToken, (_) => accessToken = null, delay: 200),
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<String?> emptyLoginResponse =
      ObservableFuture.value(null);

  // store variables:-----------------------------------------------------------
  @observable
  bool success = false;

  @observable
  ObservableFuture<String?> loginFuture = emptyLoginResponse;

  @observable
  late UserModel user;

  @computed
  bool get isLoading => loginFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future<bool> fetchUserInfor() async {
    assert(accessToken != null);

    final res = await _repository.fetchUserInfor(accessToken!);

    // if (res['message'] != null) {
    //   // do main task
    // } else {
    //   // exception task
    // }

    // if (res != null && res["user"] != null) {
    //   user = UserInfo.fromJson(res["user"]);
    //   return Future.value(true);
    // }

    return Future.value(false);
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
