import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/data/repository.dart';
import 'package:mobile/models/common/category/category.dart';
import 'package:mobile/models/common/session/session.dart';
import 'package:mobile/models/common/skill/skill.dart';
import 'package:mobile/models/rate/rate.dart';
import 'package:mobile/stores/message/message_store.dart';
import 'package:mobx/mobx.dart';

part 'common_store.g.dart';

class CommonStore = _CommonStore with _$CommonStore;

abstract class _CommonStore with Store {
  // repository instance
  final Repository _repository;

  // store for handling error messages
  final MessageStore messageStore = MessageStore();

  // constructor:---------------------------------------------------------------
  _CommonStore(Repository repository) : _repository = repository {
    // setting up disposers
    _setupDisposers();

    fetchAllCategories();
    fetchAllSkills();
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
  final int totalPage = 0;

  int programRatePage = 0;

  // observable variables:------------------------------------------------------
  @observable
  bool success = false;

  @observable
  ObservableFuture<Map<String, dynamic>?> requestFuture = emptyResponse;

  @observable
  ObservableList<RateModel> rateModels = ObservableList<RateModel>();

  @observable
  Session? session;

  @observable
  SearchingFilterModule searchingFilterModule = SearchingFilterModule();

  // computed:------------------------------------------------------------------
  @computed
  bool get isLoading => requestFuture.status == FutureStatus.pending;

  @computed
  int get programLengthList => rateModels.length;

  @computed
  Session? get sessionObserver => session;

  @computed
  List<Skill> get fetchedSkills => searchingFilterModule.getSkillList();

  @computed
  List<Category> get fetchedCategories =>
      searchingFilterModule.getCategoryList();

  @computed
  List<Skill> get selectedSkills =>
      searchingFilterModule.getSelectedSkillList();

  @computed
  Category? get selectedCategory => searchingFilterModule.getSelectedCategory();

  // actions:-------------------------------------------------------------------
  @action
  bool nextProgramRatePage() {
    if (programRatePage + 1 <= totalPage) {
      programRatePage++;

      return true;
    }
    return false;
  }

  @action
  bool prevProgramRatePage() {
    // init and do not have any data
    if (0 == programRatePage) {
      programRatePage++;
      return true;
    }

    if (programRatePage - 1 > 0) {
      programRatePage--;

      return true;
    }
    return false;
  }

  @action
  Future<void> fetchProgramRateList(int mentorID, int programID) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.successMessage = "";
      messageStore.errorMessage = "There are no AccessToken";
      messageStore.notifyExpiredTokenStatus();

      success = false;

      return;
    }

    final future = _repository.fetchProgramRateList(
      mentorID: mentorID,
      programID: programID,
      query: {
        "limit": 6,
        "page": programRatePage,
      },
    );
    requestFuture = ObservableFuture(future);

    future.then((res) {
      try {
        rateModels = ObservableList.of(RateModelList.fromJson(res!).rateModels);

        success = true;
      } catch (e) {
        // res['message']
        messageStore.errorMessage = e.toString();
        messageStore.successMessage =
            "[fetchProgramRate] error to get Program Rate List";

        success = false;
      }
    });
  }

  @action
  Future<bool?> registerProgramOfMentor({
    required int mentorID,
    required int programID,
    required Map<String, String> body,
  }) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.successMessage = "";
      messageStore.errorMessage = "There are no AccessToken";
      messageStore.notifyExpiredTokenStatus();

      success = false;

      return null;
    }

    final future = _repository.registerProgram(
      mentorID: mentorID,
      programID: programID,
      body: body,
    );
    requestFuture = ObservableFuture(future);

    future.then((res) {
      try {
        rateModels = ObservableList.of(RateModelList.fromJson(res!).rateModels);

        success = true;
      } catch (e) {
        // res['message']
        messageStore.errorMessage = e.toString();
        messageStore.successMessage =
            "[fetchProgramRate] error to get Program Rate List";

        success = false;
      }
    });

    return true;
  }

  @action
  Future<void> unregisterSessionOfProgram({
    VoidCallback? callback,
  }) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.successMessage = "";
      messageStore.errorMessage = "There are no AccessToken";
      messageStore.notifyExpiredTokenStatus();

      success = false;

      return;
    }

    final future = _repository.unregisterASessionOfProgram(
      mentorID: session!.program.mentorId,
      programID: session!.program.id,
      sessionID: session!.id,
      authToken: accessToken,
    );
    requestFuture = ObservableFuture(future);

    future.then(
      (res) {
        try {
          callback?.call();
          success = true;
        } catch (e) {
          // res['message']
          messageStore.errorMessage = e.toString();
          messageStore.successMessage = "";

          success = false;
        }
      },
    );
  }

  @action
  Future<void> markSessionOfProgramAsDone() async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.successMessage = "";
      messageStore.errorMessage = "There are no AccessToken";
      messageStore.notifyExpiredTokenStatus();

      success = false;

      return;
    }

    final future = _repository.markSessionOfProgramAsDone(
      mentorID: session!.program.mentorId,
      programID: session!.program.id,
      sessionID: session!.id,
      authToken: accessToken,
    );
    requestFuture = ObservableFuture(future);

    future.then(
      (res) {
        try {
          success = true;
        } catch (e) {
          // res['message']
          messageStore.errorMessage = e.toString();
          messageStore.successMessage = "";

          success = false;
        }
      },
    );
  }

  @action
  Future<void> reviewSessionOfProgram(ReviewModel reviewModel) async {
    String? accessToken = await _repository.authToken;

    if (null == accessToken) {
      messageStore.successMessage = "";
      messageStore.errorMessage = "There are no AccessToken";
      messageStore.notifyExpiredTokenStatus();

      success = false;

      return;
    }

    final future = _repository.reviewSessionOfProgram(
      mentorID: session!.program.mentorId,
      programID: session!.program.id,
      sessionID: session!.id,
      authToken: accessToken,
      rate: reviewModel.rate,
      comment: reviewModel.comment,
    );
    requestFuture = ObservableFuture(future);

    future.then(
      (res) {
        try {
          success = true;
        } catch (e) {
          // res['message']
          messageStore.errorMessage = e.toString();
          messageStore.successMessage = "";

          success = false;
        }
      },
    );
  }

  @action
  Future<void> fetchAllSkills() async {
    final future = _repository.fetchAllSkills();

    requestFuture = ObservableFuture(future);

    future.then(
      (res) {
        try {
          searchingFilterModule.setSkills(SkillList.fromJson(res!).skills);
          success = true;
        } catch (e) {
          // res['message']
          messageStore.errorMessage = e.toString();
          messageStore.successMessage = "";

          success = false;
        }
      },
    );
  }

  @action
  Future<void> fetchAllCategories() async {
    final future = _repository.fetchAllCategories();

    requestFuture = ObservableFuture(future);

    future.then(
      (res) {
        try {
          searchingFilterModule
              .setCategories(CategoryList.fromJson(res!).categories);
          success = true;
        } catch (e) {
          // res['message']
          messageStore.errorMessage = e.toString();
          messageStore.successMessage = "";

          success = false;
        }
      },
    );
  }

  @action
  void setSessionObserver(Session session) {
    this.session = session;
  }

  // general methods:-----------------------------------------------------------

  RateModel getRateCommentAt(int index) => rateModels.elementAt(index);

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}

class ReviewModel {
  final int rate;
  final String comment;

  ReviewModel({
    required this.rate,
    required this.comment,
  });
}

class SearchingFilterModule implements Equatable {
  final List<Category> categories = <Category>[];
  final List<Skill> skills = <Skill>[];
  OrderType orderType = OrderType.asc;
  OrderByType orderByType = OrderByType.name;

  Category? selectedCategory;
  List<Skill> selectedSkills = <Skill>[];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    if (selectedCategory != null) {
      map["category"] = selectedCategory!.id;
    }
    if (selectedSkills.isNotEmpty) {
      map["skills"] = selectedSkills.map((skill) => skill.id).toList();
    }

    map["orderBy"] = orderByType.name;
    map["order"] = orderType.name;

    return map;
  }

  void setCategories(List<Category> categories) {
    this.categories.clear();
    this.categories.addAll(categories);
  }

  List<Category> getCategoryList() => categories;

  void setSkills(List<Skill> skills) {
    this.skills.clear();
    this.skills.addAll(skills);
  }

  List<Skill> getSkillList() => skills;

  void setOrder(OrderType orderType) {
    this.orderType = orderType;
  }

  void setOrderBy(OrderByType orderByType) {
    this.orderByType = orderByType;
  }

  void changeSelectedCategory(Category category) {
    selectedCategory = category;
  }

  Category? getSelectedCategory() => selectedCategory;

  void updateSelectedSkillList(List<Skill> skills) {
    selectedSkills.clear();
    selectedSkills.addAll(skills);
  }

  List<Skill> getSelectedSkillList() => selectedSkills;

  @override
  List<Object?> get props => [selectedCategory, selectedSkills];

  @override
  bool? get stringify => false;
}

enum OrderType {
  asc,
  desc,
}

enum OrderByType {
  name,
  createAt,
}
