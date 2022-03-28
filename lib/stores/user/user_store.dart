import 'package:mobile/data/repository.dart';
import 'package:mobile/models/user/user.dart';
import 'package:mobx/mobx.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  // repository instance
  final Repository _repository;

  // store for handling form errors
  // final FormErrorStore formErrorStore = FormErrorStore();

  // store for handling error messages
  // final MessageStore messageStore = MessageStore();

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
  static ObservableFuture<Map<String, dynamic>?> emptyLoginResponse =
      ObservableFuture.value(null);

  // store variables:-----------------------------------------------------------
  @observable
  bool success = false;

  @observable
  ObservableFuture<Map<String, dynamic>?> loginFuture = emptyLoginResponse;

  @observable
  UserModel? user;

  @computed
  bool get isLoading => loginFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future<bool> fetchUserInfor() async {
    assert(accessToken != null);

    final future = _repository.fetchUserInfor(accessToken!);
    loginFuture = ObservableFuture(future);

    future.then((res) {
      try {
        user = UserModel.fromJson(res!);
        success = true;
        return Future.value(true);
      } catch (e) {
        // res['message']
        success = false;
        return Future.value(false);
      }
    });

    return Future.value(true);
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
