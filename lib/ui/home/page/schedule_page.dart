import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/constants/dimens.dart';
import 'package:mobile/constants/properties.dart';
import 'package:mobile/di/components/service_locator.dart';
import 'package:mobile/models/common/session/session.dart';
import 'package:mobile/stores/schedule/schedule_store.dart';
import 'package:mobile/stores/theme/theme_store.dart';
import 'package:mobile/utils/application/application_utils.dart';
import 'package:mobile/utils/locale/app_localization.dart';
import 'package:mobile/widgets/background_colorful/linear_gradient_background.dart';
import 'package:mobile/widgets/card/event_card.dart';
import 'package:mobile/widgets/glassmorphism_widgets/container_style.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:mobile/utils/extension/datetime_extension.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  // controller:----------------------------------------------------------------

  // store:---------------------------------------------------------------------

  final ScheduleStore _scheduleStore = getIt<ScheduleStore>();
  final ThemeStore _themeStore = getIt<ThemeStore>();

  // variable:------------------------------------------------------------------
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();

  late final List<Tab> _tab;

  late final TabBar _tabBar;

  final double _heightTabBar = 150;
  late final double _positionedTopHeaderTabBar;
  late final double _positionedToBuild;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _scheduleStore.fetchAllSessionsByList();
    _scheduleStore.fetchSessionsByDate(date: _selectedDate);

    _tab = [
      Tab(
        child: Text(
          AppLocalizations.of(context).translate("calendar_translate"),
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.white),
        ),
      ),
      Tab(
        child: Text(
          AppLocalizations.of(context).translate("list_translate"),
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.white),
        ),
      ),
    ];

    _tabBar = TabBar(
      tabs: _tab,
      // padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
      indicator: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: Dimens.kMaxBorderRadius,
      ),
      unselectedLabelColor: Colors.black54,
      labelStyle: Theme.of(context).textTheme.bodyMedium,
      isScrollable: true,
    );

    _positionedTopHeaderTabBar =
        _heightTabBar - _tabBar.preferredSize.height / 2;

    _positionedToBuild = _heightTabBar + _tabBar.preferredSize.height;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tab.length,
      child: Stack(
        children: [
          LinearGradientBackground(
            colors: _themeStore.lineToLineGradientColors,
            stops: null,
          ),
          CustomScrollView(
            clipBehavior: Clip.none,
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(height: _positionedToBuild),
              ),
              SliverFillRemaining(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildCalendarTabView(context),
                    // const SizedBox(),
                    _buildGroupListTabView(context),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: kBottomNavigationBarHeight),
              ),
            ],
          ),
          _buildHeader(context),
          _buildTabHeader(),
          Observer(
            builder: (_) {
              return _scheduleStore.success
                  ? const SizedBox.shrink()
                  : ApplicationUtils.showErrorMessage(
                      context,
                      "Find_sessions_error_translate",
                      _scheduleStore.getFailedMessageKey,
                    );
            },
          ),
        ],
      ),
    );
  }

  Positioned _buildTabHeader() {
    return Positioned.fill(
      top: _positionedTopHeaderTabBar,
      bottom: null,
      child: Center(
        child: PreferredSize(
          preferredSize: _tabBar.preferredSize,
          child: GlassmorphismContainer(
            child: _tabBar,
            blur: Properties.hevily_blur_glass_morphism,
            opacity: Properties.hevily_opacity_glass_morphism,
            padding: const EdgeInsets.all(2),
            background: Theme.of(context).highlightColor,
          ),
        ),
      ),
    );
  }

  GlassmorphismContainer _buildHeader(BuildContext context) {
    return GlassmorphismContainer(
      width: double.infinity,
      height: _heightTabBar,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimens.horizontal_padding,
            vertical: Dimens.vertical_padding),
        child: SafeArea(
          bottom: false,
          child: Text(
            AppLocalizations.of(context)
                .translate('next_sessions_title_translate'),
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ),
      blur: Properties.blur_glass_morphism,
      opacity: Properties.opacity_glass_morphism,
      radius: Dimens.kBorderRadiusValue,
    );
  }

  Widget _buildGroupListTabView(BuildContext context) {
    return Observer(
      builder: (_) {
        return StickyGroupedListView<Session, DateTime>(
          padding: const EdgeInsets.only(
              bottom: kBottomNavigationBarHeight + Dimens.vertical_margin),
          elements: _scheduleStore.listListSessions,
          groupBy: (element) => element.expectedDate!.today(toUTC: false),
          groupSeparatorBuilder: (Session groupByValue) {
            return _getGroupSeparator(groupByValue, context);
          },
          itemBuilder: (context, Session element) => EventCard(
            session: element,
            // onViewDetailTap: () {},
            // onSendMessageTap: () {},
          ),
          itemComparator: (item1, item2) =>
              item1.expectedDate!.compareTo(item2.expectedDate!),
          groupComparator: (item1, item2) => item1.compareTo(item2),
          floatingHeader: true,
          order: StickyGroupedListOrder.ASC,
          physics: const BouncingScrollPhysics(),
        );
      },
    );
  }

  SizedBox _getGroupSeparator(Session groupByValue, BuildContext context) {
    return SizedBox(
      height: 50,
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            groupByValue.expectedDate!.toDDMMYYYYString(),
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarTabView(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconTheme(
                    data: Theme.of(context).iconTheme,
                    child: const Icon(
                      Icons.calendar_today_outlined,
                    ),
                  ),
                  const SizedBox(
                    width: Dimens.vertical_margin,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: _selectedDate.toMonthNameString(
                              locale: AppLocalizations.of(context)
                                  .locale
                                  .languageCode),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        TextSpan(
                          text: "  ${_selectedDate.year}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedDate = DateTime.now();
                    _focusedDate = DateTime.now();
                  });
                },
                child: Text(
                  AppLocalizations.of(context).translate("today"),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: Dimens.vertical_margin,
        ),
        TableCalendar(
          focusedDay: _focusedDate,
          firstDay: DateTime.now(),
          lastDay: DateTime.now().add(const Duration(days: 14)),
          calendarFormat: CalendarFormat.week,
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: Color.alphaBlend(
                Colors.orange.withOpacity(0.9),
                Theme.of(context).highlightColor.withOpacity(0.5),
              ),
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: Color.alphaBlend(
                Colors.orange.shade300.withOpacity(0.7),
                Theme.of(context).primaryColor.withOpacity(0.4),
              ),
              shape: BoxShape.circle,
            ),
            disabledTextStyle: TextStyle(
                color: Color.alphaBlend(
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    Colors.white)),
          ),
          headerVisible: false,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDate, day);
          },
          daysOfWeekHeight: Dimens.medium_text,
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              if (selectedDay.compareTo(_selectedDate) != 0) {
                _scheduleStore.fetchSessionsByDate(date: selectedDay);

                _selectedDate = selectedDay;
                _focusedDate = focusedDay;
              }
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDate = focusedDay;
          },
        ),
        Expanded(
          child: Observer(
            builder: (_) {
              if (_scheduleStore.isCalendarLoading) {
                return Container(); // build shimmer
              } else {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (_, index) => EventCard(
                    session: _scheduleStore.getCalendarSessionsAt(index)!,
                    // onViewDetailTap: () {},
                    // onSendMessageTap: () {},
                  ),
                  itemCount: _scheduleStore.sizeCalendarSessions,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
