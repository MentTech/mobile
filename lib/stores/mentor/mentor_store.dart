import 'package:flutter/widgets.dart';
import 'package:mobile/data/repository.dart';
import 'package:mobile/models/mentor/mentor.dart';
import 'package:mobile/stores/message/message_store.dart';
import 'package:mobx/mobx.dart';

part 'mentor_store.g.dart';

class MentorStore = _MentorStore with _$MentorStore;

abstract class _MentorStore with Store {
  // repository instance
  final Repository _repository;

  // store for handling error messages
  final MessageStore messageStore = MessageStore();

  // constructor:---------------------------------------------------------------
  _MentorStore(Repository repository) : _repository = repository {
    // setting up disposers
    _setupDisposers();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;
  VoidCallback? callback;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
      reaction((_) => requestFuture.status, (FutureStatus status) {
        if (status == FutureStatus.fulfilled) {
          if (callback != null) {
            callback!.call();
            callback = null;
            requestFuture = emptyResponse;
          }
        }
      }),
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<Map<String, dynamic>?> emptyResponse =
      ObservableFuture.value(null);

  // non-observable variables:--------------------------------------------------
  final int perPage = 10;

  int totalPage = 0;

  String searchKey = "";

  // observable variables:------------------------------------------------------
  @observable
  bool success = false;

  @observable
  int page = 0;

  @observable
  ObservableFuture<Map<String, dynamic>?> requestFuture = emptyResponse;

  @observable
  ObservableList<MentorModel> listMentors = ObservableList<MentorModel>();

  // computed:------------------------------------------------------------------
  @computed
  bool get isLoading => requestFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  bool nextPage() {
    if (page + 1 <= totalPage) {
      page++;

      return true;
    }
    return false;
  }

  @action
  bool prevPage() {
    // init and do not have any data
    if (0 == page) {
      page++;
      return true;
    }

    if (page - 1 > 0) {
      page--;

      return true;
    }
    return false;
  }

  @action
  Future<void> searchMentors() async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.successMessage = "";
      messageStore.errorMessage = "There are no AccessToken";
      messageStore.notifyExpiredTokenStatus();

      success = false;
    }

    Map<String, dynamic> param = {
      "order": "desc",
      "page": page,
      "limit": perPage,
    };

    if (searchKey.isNotEmpty) {
      param["keyword"] = searchKey;
    }

    final future = _repository.searchMentor(param);
    requestFuture = ObservableFuture(future);

    future.then((res) {
      // totalPage = res!["totalPage"];
      // listMentors = ObservableList.of(MentorModelList.fromJson(res).list);
      try {
        totalPage = res!["totalPage"];
        listMentors = ObservableList.of(MentorModelList.fromJson(res).list);

        success = true;
      } catch (e) {
        // res['message']
        messageStore.errorMessage = e.toString();
        messageStore.successMessage = "";

        success = false;
      }
    });
  }

  // general methods:-----------------------------------------------------------
  MentorModel at(int index) {
    return listMentors.elementAt(index);
  }

  int get length => listMentors.length;

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
