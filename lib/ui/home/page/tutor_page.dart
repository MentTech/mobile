import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/utils/device/device_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TutorPage extends StatefulWidget {
  const TutorPage({Key? key}) : super(key: key);

  @override
  _TutorPageState createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
  // controller:----------------------------------------------------------------
  final TextEditingController editingController = TextEditingController();

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  // store:---------------------------------------------------------------------
  // late TutorStore tutorStore;
  // late SpecialtiesStore specialtiesStore;

  // variable:------------------------------------------------------------------
  int curPage = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // tutorStore = Provider.of<TutorStore>(context);
    // specialtiesStore = Provider.of<SpecialtiesStore>(context);
    // specialtiesStore.resetChoosenSpecList();
  }

  @override
  void dispose() {
    refreshController.dispose();
    editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => DeviceUtils.hideKeyboard(context),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimens.horizontal_padding,
            vertical: Dimens.vertical_padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const <Widget>[
            // Text(
            //   AppLocalizations.of(context).translate("tutor_title"),
            //   style: TextStyle(
            //     fontFamily: FontFamily.gilroy,
            //     fontSize: Dimens.largeText,
            //     color: Theme.of(context).primaryColor.withAlpha(200),
            //     letterSpacing: 2,
            //   ),
            // ),
            // const SizedBox(
            //   height: Dimens.verticalMargin,
            // ),
            // CustomTextInputForm(
            //   textEditingController: editingController,
            //   onFieldSubmitted: (value) {
            //     refreshController.requestRefresh();
            //   },
            // ),
            // Expanded(
            //   child: Observer(
            //     builder: (_) {
            //       return Column(
            //         children: [
            //           ToggleHashTag(
            //             listTag: specialtiesStore.listSpecialties,
            //             listChoosenTag: specialtiesStore.listChoosenSpecialties,
            //             toggleItemFunc: (item) {
            //               specialtiesStore.toggleItemChoosenSpecList(item);
            //               refreshController.requestRefresh();
            //             },
            //           ),
            //           const SizedBox(
            //             height: Dimens.smallVerticalMargin,
            //           ),
            //           Expanded(
            //             child: SmartRefresher(
            //                 controller: refreshController,
            //                 enablePullUp: true,
            //                 enablePullDown: true,
            //                 header:
            //                     FetchMethodWidget.fetchHeaderStatus(context),
            //                 footer: FetchMethodWidget.fetchFooterStatus(),
            //                 onRefresh: () async {
            //                   if (curPage > 1) {
            //                     curPage--;
            //                   }
            //                   await tutorStore
            //                       .fetchTutors(
            //                           page: curPage,
            //                           searchkey: editingController.text.isEmpty
            //                               ? null
            //                               : editingController.text,
            //                           specialties: specialtiesStore
            //                               .listChoosenSpecialtiesNameNullSafety)
            //                       .then((value) {
            //                     if (tutorStore.isSearch) {
            //                       DeviceUtils.showSnackBar(
            //                           context,
            //                           AppLocalizations.of(context)
            //                               .translate("search_tutor_results")
            //                               .format([
            //                             tutorStore.countTutors.toString()
            //                           ]));
            //                     }

            //                     refreshController.refreshCompleted();
            //                   });
            //                 },
            //                 onLoading: () async {
            //                   await tutorStore
            //                       .fetchTutors(
            //                           page: curPage,
            //                           searchkey: editingController.text.isEmpty
            //                               ? null
            //                               : editingController.text,
            //                           specialties: specialtiesStore
            //                               .listChoosenSpecialtiesNameNullSafety)
            //                       .then((value) {
            //                     if (value) {
            //                       curPage++;
            //                     }
            //                     refreshController.loadComplete();
            //                   });
            //                 },
            //                 child: ListView.builder(
            //                     itemBuilder: (context, index) {
            //                       return _buildItem(
            //                           context, tutorStore.listTutor[index]);
            //                     },
            //                     itemCount: tutorStore.listTutor.length)),
            //           ),
            //         ],
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // Widget _buildItem(BuildContext context, UserInfo tutor) {
  //   return TutorCard(
  //     key: UniqueKey(),
  //     // because of backend do not send tutor infor enough
  //     isShowFavButton: editingController.text.isEmpty &&
  //         specialtiesStore.listChoosenSpecialtiesNameNullSafety == null,
  //     tutorInfo: tutor,
  //     toggleFavourite: (String userID) {
  //       tutorStore.toggleFavTutor(userID);
  //     },
  //   );
  // }
}
