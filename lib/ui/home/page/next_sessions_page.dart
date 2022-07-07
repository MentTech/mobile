import 'package:flutter/material.dart';
import 'package:mobile/models/common/session/session.dart';
import 'package:mobile/stores/user/user_store.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/errors_widget/error_widget.dart';
import 'package:mobile/widgets/template/glassmorphism_appbar_only.dart';

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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) =>
                              _buildSessionContainer(
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
  Widget _buildSessionContainer(Session session) {
    return const SizedBox.shrink();
  }

  // [TODO] buid shimmer
  Widget _buildShimmerLoadingPage() {
    return const SizedBox.shrink();
  }
}
