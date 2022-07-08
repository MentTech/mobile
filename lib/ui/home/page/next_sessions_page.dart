import 'package:flutter/material.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/models/common/session/session.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/ui/session_detail/session_detail_full_feature.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/utils/routes/routes.dart';
import 'package:mobile/widgets/errors_widget/error_widget.dart';
import 'package:mobile/widgets/item/session_ticket_item.dart';
import 'package:mobile/widgets/template/glassmorphism_appbar_only.dart';
import 'package:provider/provider.dart';

class NextSessionsPage extends StatefulWidget {
  const NextSessionsPage({Key? key}) : super(key: key);

  @override
  State<NextSessionsPage> createState() => _NextSessionsPageState();
}

class _NextSessionsPageState extends State<NextSessionsPage> {
  // store:---------------------------------------------------------------------
  late final UserStore _userStore;

  Future<List<Session>> loadData() async {
    await _userStore.fetchNextSessions();

    List<Session> sessions = _userStore.nextSessions;

    return sessions;
  }

  @override
  void initState() {
    super.initState();

    _userStore = Provider.of<UserStore>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return GlassmorphismGradientScaffoldAppbar(
      appbarName: AppLocalizations.of(context)
          .translate("next_sessions_title_translate"),
      child: SafeArea(
        child: FutureBuilder<List<Session>>(
          future: loadData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildShimmerLoadingPage();
            } else {
              if (snapshot.hasError) {
                return ErrorContentWidget(
                  titleError:
                      AppLocalizations.of(context).translate("home_tv_error"),
                  contentError: snapshot.error.toString(),
                );
              } else {
                if (snapshot.hasData) {
                  // should be change to group list
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) => _buildSessionItem(
                              snapshot.data!.elementAt(index)),
                          itemCount: snapshot.data!.length,
                        ),
                      ),
                    ],
                  );
                } else {
                  return ErrorContentWidget(
                    titleError:
                        AppLocalizations.of(context).translate("home_tv_error"),
                    contentError: AppLocalizations.of(context).translate(
                      _userStore.getFailedMessageKey,
                    ),
                  );
                }
              }
            }
          },
        ),
      ),
    );
  }

  // [TODO] build session container
  Widget _buildSessionItem(Session session) {
    return SessionTicketItem(
      program: session.program,
      margin: const EdgeInsets.only(
        top: Dimens.vertical_margin,
      ),
      callbackIfProgramNotNull: () {
        Routes.route(
          context,
          SesstionDetailScreen(
            sessionId: session.id,
          ),
        );
      },
    );
  }

  // [TODO] buid shimmer
  Widget _buildShimmerLoadingPage() {
    return const SizedBox.shrink();
  }
}
