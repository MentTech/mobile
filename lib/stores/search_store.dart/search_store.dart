import 'package:mobile/data/repository.dart';
import 'package:mobile/models/common/category/category.dart';
import 'package:mobile/models/common/skill/skill.dart';
import 'package:mobile/models/mentor/mentor.dart';
import 'package:mobile/stores/message/message_store.dart';
import 'package:mobile/stores/search_store.dart/search_type_enum.dart';
import 'package:mobx/mobx.dart';

part 'search_store.g.dart';

class SearchStore = _SearchStore with _$SearchStore;

abstract class _SearchStore with Store {
  // repository instance
  final Repository _repository;

  // store for handling error messages
  final MessageStore messageStore = MessageStore();

  // constructor:---------------------------------------------------------------
  _SearchStore(Repository repository) : _repository = repository {
    // setting up disposers
    _setupDisposers();
  }

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<Map<String, dynamic>?> emptyResponse =
      ObservableFuture.value(null);

  // non-observable variables:--------------------------------------------------

  // database
  late final List<Category> categories;
  late final List<Skill> skills;

  Future initializeDatabase() async {
    await fetchAllCategories();
    await fetchAllSkills();
  }

  // observable variables:------------------------------------------------------
  @observable
  bool success = false;

  @observable
  String searchKey = "";

  @observable
  OrderType orderType = OrderType.asc;

  @observable
  OrderByType orderByType = OrderByType.name;

  @observable
  Category? category;

  @observable
  ObservableList<Skill> selectedSkills = ObservableList<Skill>();

  @observable
  ObservableFuture<Map<String, dynamic>?> requestCategoriesFuture =
      emptyResponse;

  @observable
  ObservableFuture<Map<String, dynamic>?> requestSkillsFuture = emptyResponse;

  @observable
  ObservableList<MentorModel> listMentors = ObservableList<MentorModel>();

  // computed:------------------------------------------------------------------
  @computed
  bool get isLoading =>
      (requestCategoriesFuture.status == FutureStatus.pending) ||
      (requestSkillsFuture.status == FutureStatus.pending);

  @computed
  List<Category> get categoryList => categories;

  @computed
  List<Skill> get skillList => skills;

  @computed
  Category? get selectedCategory => category;

  @computed
  List<Skill> get selectedSkillList => selectedSkills;

  @computed
  OrderType get sortType => orderType;

  @computed
  OrderByType get orderBy => orderByType;

  // actions:-------------------------------------------------------------------
  @action
  void onChangeSearchKey(String keyword) {
    searchKey = keyword;
  }

  @action
  void changeSelectedCategory(int id) {
    if (null != selectedCategory && id == selectedCategory!.id) {
      category = null;
    } else {
      category = categories.firstWhere((element) => element.id == id);
    }
  }

  @action
  void updateSelectedSkillList(List<Skill> skills) {
    selectedSkills.clear();
    selectedSkills.addAll(skills);
  }

  @action
  void updateSelectedSkills(int id) {
    Skill skill = skills.firstWhere((element) => element.id == id);

    if (selectedSkills.contains(skill)) {
      selectedSkills.remove(skill);
    } else {
      selectedSkills.add(skill);
    }
  }

  @action
  void setOrder(OrderType orderType) {
    this.orderType = orderType;
  }

  @action
  void setOrderBy(OrderByType orderByType) {
    this.orderByType = orderByType;
  }

  // init database:-------------------------------------------------------------
  Future fetchAllSkills() async {
    final future = _repository.fetchAllSkills();

    await future.then(
      (res) {
        try {
          skills = SkillList.fromJson(res!).skills;
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

  Future fetchAllCategories() async {
    final future = _repository.fetchAllCategories();

    await future.then(
      (res) {
        try {
          categories = CategoryList.fromJson(res!).categories;
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

  // general methods:-----------------------------------------------------------

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    if (searchKey.isNotEmpty) {
      map["keyword"] = searchKey;
    }

    if (selectedCategory != null) {
      map["category"] = selectedCategory!.id;
    }
    if (selectedSkills.isNotEmpty) {
      map["skills"] = selectedSkills.map((skill) => skill.id).toList();
    }

    map["orderBy"] = orderByType.name;
    map["order"] = orderType.name;

    // map["page"] = page;
    // map["limit"] = limit;

    return map;
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
