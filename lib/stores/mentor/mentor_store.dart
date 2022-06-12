import 'package:flutter/widgets.dart';
import 'package:mobile/data/repository.dart';
import 'package:mobile/models/common/program/program.dart';
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

  // observable variables:------------------------------------------------------
  @observable
  bool success = false;

  @observable
  int page = 0;

  @observable
  ObservableFuture<Map<String, dynamic>?> requestFuture = emptyResponse;

  @observable
  ObservableList<MentorModel> listMentors = ObservableList<MentorModel>();

  @observable
  ObservableList<MentorModel> favouriteMentorList =
      ObservableList<MentorModel>();

  @observable
  ObservableList<MentorModel> recommendedMentorList =
      ObservableList<MentorModel>();

  @observable
  MentorModel? mentorModel;

  @observable
  Program? program;

  // computed:------------------------------------------------------------------
  @computed
  bool get isLoading => requestFuture.status == FutureStatus.pending;

  @computed
  MentorModel? get getMentor => mentorModel;

  @computed
  bool get hasMentor => mentorModel != null;

  @computed
  bool get hasRecommendedMentors => recommendedMentorList.isNotEmpty;

  @computed
  bool get hasFavouriteMentors => favouriteMentorList.isNotEmpty;

  @computed
  Program? get getProgram => program;

  @computed
  bool get hasProgram => program != null;

  @computed
  int get recommendedLength => recommendedMentorList.length;

  @computed
  int get favouriteLength => favouriteMentorList.length;

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
  Future resetPage() async {
    page = 0;
  }

  @action
  Future<void> searchMentors(Map<String, dynamic> parameterQuery) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.successMessage = "";
      messageStore.errorMessage = "There are no AccessToken";
      messageStore.notifyExpiredTokenStatus();

      success = false;
    }

    parameterQuery.addAll({
      "page": page,
      "limit": perPage,
    });

    final future = _repository.searchMentor(parameterQuery);
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

  @action
  Future<void> fetchRecommendMentors() async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.successMessage = "";
      messageStore.errorMessage = "There are no AccessToken";
      messageStore.notifyExpiredTokenStatus();

      success = false;
    }

    final future = _repository.fetchRecommendedMentors();

    future.then((res) {
      try {
        recommendedMentorList =
            ObservableList.of(MentorModelList.fromJson(res!).list);

        success = true;
      } catch (e) {
        // res['message']
        messageStore.errorMessage = e.toString();
        messageStore.successMessage = "";

        success = false;
      }
    });
  }

  @action
  Future<void> fetchFavouriteMentors(List<int> ids) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.successMessage = "";
      messageStore.errorMessage = "There are no AccessToken";
      messageStore.notifyExpiredTokenStatus();

      success = false;
    }

    final future = _repository.fetchMultipleMentorsByIds(
      authToken: accessToken!,
      ids: ids,
    );

    future.then((res) {
      favouriteMentorList =
          ObservableList.of(MentorModelList.fromJson(res!).list);
      try {
        success = true;
      } catch (e) {
        // res['message']
        messageStore.errorMessage = e.toString();
        messageStore.successMessage = "";

        success = false;
      }
    });
  }

  @action
  Future<void> fetchAMentor(int mentorID) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.successMessage = "";
      messageStore.errorMessage = "There are no AccessToken";
      messageStore.notifyExpiredTokenStatus();

      success = false;

      return;
    }

    final future = _repository.fetchMentor(mentorID);
    requestFuture = ObservableFuture(future);

    future.then((res) {
      try {
        mentorModel = MentorModel.fromJson(res!);

        success = true;
      } catch (e) {
        // res['message']
        messageStore.errorMessage = e.toString();
        messageStore.successMessage = "";

        success = false;
      }
    });
  }

  @action
  Future<void> fetchProgramOfMentor(int programID) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.successMessage = "";
      messageStore.errorMessage = "There are no AccessToken";
      messageStore.notifyExpiredTokenStatus();

      success = false;

      return;
    }

    if (null == mentorModel) {
      messageStore.successMessage = "";
      messageStore.errorMessage = "There are no MentorModel";
      messageStore.notifyExpiredTokenStatus();

      success = false;

      return;
    }

    final future = _repository.fetchProgram(mentorModel!.id, programID);
    requestFuture = ObservableFuture(future);

    future.then((res) {
      try {
        program = Program.fromJson(res!);

        success = true;
      } catch (e) {
        // res['message']
        messageStore.errorMessage = e.toString();
        messageStore.successMessage = "";

        success = false;
      }
    });
  }

  @action
  void clearCurrentMentor() {
    mentorModel = null;
  }

  @action
  void clearCurrentProgram() {
    program = null;
  }

  // general methods:-----------------------------------------------------------
  MentorModel at(int index) {
    return listMentors.elementAt(index);
  }

  MentorModel recommendedAt(int index) {
    return recommendedMentorList.elementAt(index);
  }

  MentorModel favouriteAt(int index) {
    return favouriteMentorList.elementAt(index);
  }

  int get length => listMentors.length;

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
