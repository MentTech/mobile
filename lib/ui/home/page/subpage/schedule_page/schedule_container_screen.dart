// import 'package:flutter/material.dart';
// import 'package:mobile/constants/dimens.dart';
// import 'package:mobile/utils/device/device_utils.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:table_calendar/table_calendar.dart';

// class DetailScheduleContainerScreen extends StatefulWidget {
//   const DetailScheduleContainerScreen({Key? key}) : super(key: key);

//   @override
//   _DetailScheduleContainerScreenState createState() =>
//       _DetailScheduleContainerScreenState();
// }

// class _DetailScheduleContainerScreenState
//     extends State<DetailScheduleContainerScreen> {
  

//   @override
//   Widget build(BuildContext context) {

//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           titleSpacing: 30,
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Daily',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 24,
//                 ),
//               ),
//               IconButton(
//                 padding: EdgeInsets.zero,
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.search,
//                   size: 24 * _scaleScreen,
//                 ),
//               ),
//             ],
//           ),
//           bottom: PreferredSize(
//             preferredSize: _tabBar.preferredSize,
//             child: Container(
//               padding: const EdgeInsets.all(4),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade600,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: TabBar(
//                 tabs: const [
//                   Tab(text: 'Workout'),
//                   Tab(text: 'Nutrition'),
//                 ],
//                 // padding: EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
//                 indicator: BoxDecoration(
//                   color: Theme.of(context).primaryColor,
//                   borderRadius: Dimens.kBorderRadius,
//                 ),
//                 unselectedLabelColor: Colors.black54,
//                 labelStyle: Theme.of(context).textTheme.bodyMedium,
//                 isScrollable: true,
//               ),
//             ),
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             SingleChildScrollView(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 30 * _scaleScreen),
//                 child: Column(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16 * _scaleScreen,
//                           vertical: 16 * _scaleScreen),
//                       margin: const EdgeInsets.symmetric(
//                           vertical: 16 * _scaleScreen),
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         borderRadius: Dimens.kBorderRadius,
//                         color: Theme.of(context).indicatorColor,
//                       ),
//                       child: Row(
//                         children: [
//                           Expanded(
//                               child: Column(
//                             children: [
//                               Text(
//                                 'Workout',
//                                 style: Theme.of(context).textTheme.bodySmall,
//                               ),
//                               Text(
//                                 '0',
//                                 style: Theme.of(context).textTheme.bodySmall,
//                               ),
//                             ],
//                           )),
//                           Expanded(
//                               child: Container(
//                             child: Column(
//                               children: [
//                                 Text(
//                                   'kcal',
//                                   style: Theme.of(context).textTheme.bodySmall,
//                                 ),
//                                 Text(
//                                   '0',
//                                   style: Theme.of(context).textTheme.bodySmall,
//                                 )
//                               ],
//                             ),
//                             decoration: BoxDecoration(
//                               border: Border(
//                                 right: BorderSide(
//                                     color: Colors.grey.shade700, width: 1),
//                                 left: BorderSide(
//                                     color: Colors.grey.shade700, width: 1),
//                               ),
//                             ),
//                           )),
//                           Expanded(
//                             child: Column(
//                               children: [
//                                 Text(
//                                   'Time (min)',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodySmall!
//                                       .copyWith(
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                 ),
//                                 Text(
//                                   '0',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodySmall!
//                                       .copyWith(
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     TableCalendar(
//                       firstDay: DateTime.utc(2010, 10, 16),
//                       lastDay: DateTime.utc(2030, 3, 14),
//                       focusedDay: DateTime.now(),
//                       calendarStyle: const CalendarStyle(),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 30 * _scaleScreen, vertical: 20 * _scaleScreen),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16 * _scaleScreen,
//                           vertical: 16 * _scaleScreen),
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).indicatorColor,
//                         borderRadius: Dimens.kBorderRadius,
//                       ),
//                       child: Column(
//                         children: [
//                           Container(
//                             decoration: const BoxDecoration(
//                               color: Colors.white70,
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(15),
//                                 topRight: Radius.circular(15),
//                               ),
//                             ),
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16 * _scaleScreen,
//                                 vertical: 16 * _scaleScreen),
//                             margin:
//                                 const EdgeInsets.only(bottom: 8 * _scaleScreen),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                     child: Column(
//                                   children: [
//                                     Image.asset('assets/eat.png'),
//                                     Text(
//                                       '860',
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .bodySmall!
//                                           .copyWith(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 18,
//                                           ),
//                                     ),
//                                     Text(
//                                       'Ate',
//                                       style:
//                                           Theme.of(context).textTheme.bodySmall,
//                                     ),
//                                   ],
//                                 )),
//                                 CircularPercentIndicator(
//                                   radius: 100,
//                                   lineWidth: 15,
//                                   animation: true,
//                                   percent: 0.7,
//                                   center: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         "1625",
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodySmall,
//                                       ),
//                                       Text(
//                                         "kCal Left",
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodySmall,
//                                       ),
//                                     ],
//                                   ),
//                                   backgroundColor: const Color(0xffebebeb),
//                                   circularStrokeCap: CircularStrokeCap.round,
//                                   progressColor: Theme.of(context).primaryColor,
//                                   animationDuration: 1000,
//                                 ),
//                                 Expanded(
//                                     child: Column(
//                                   children: [
//                                     Image.asset('assets/calo.png'),
//                                     Text(
//                                       '120',
//                                       style:
//                                           Theme.of(context).textTheme.bodySmall,
//                                     ),
//                                     Text(
//                                       'Ate',
//                                       style:
//                                           Theme.of(context).textTheme.bodySmall,
//                                     ),
//                                   ],
//                                 )),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             decoration: const BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.only(
//                                 bottomRight: Radius.circular(15),
//                                 bottomLeft: Radius.circular(15),
//                               ),
//                             ),
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 10 * _scaleScreen, horizontal: 16),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 8),
//                                     child: Column(
//                                       children: [
//                                         Text(
//                                           'Carb',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodySmall,
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               vertical: 4 * _scaleScreen),
//                                           child: LinearProgressIndicator(
//                                             backgroundColor: Colors.grey,
//                                             color:
//                                                 Theme.of(context).primaryColor,
//                                             value: 46 / 158,
//                                           ),
//                                         ),
//                                         Text(
//                                           '46 / 158',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodySmall,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 16),
//                                     child: Column(
//                                       children: [
//                                         Text(
//                                           'Protein',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodySmall,
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               vertical: 4 * _scaleScreen),
//                                           child: LinearProgressIndicator(
//                                             backgroundColor: Colors.grey,
//                                             color:
//                                                 Theme.of(context).primaryColor,
//                                             value: 46 / 158,
//                                           ),
//                                         ),
//                                         Text(
//                                           '46 / 158',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodySmall,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 8),
//                                     child: Column(
//                                       children: [
//                                         Text(
//                                           'Fat',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodySmall,
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               vertical: 4 * _scaleScreen),
//                                           child: LinearProgressIndicator(
//                                             backgroundColor: Colors.grey,
//                                             color:
//                                                 Theme.of(context).primaryColor,
//                                             value: 46 / 158,
//                                           ),
//                                         ),
//                                         Text(
//                                           '46 / 158',
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodySmall,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 8 * _scaleScreen),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Your food log',
//                             style: Theme.of(context).textTheme.bodySmall,
//                           ),
//                           ElevatedButton(
//                             onPressed: () {},
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   Icons.add_circle,
//                                   size: 16 * _scaleScreen,
//                                   color: Theme.of(context).indicatorColor,
//                                 ),
//                                 Text('Meal',
//                                     style:
//                                         Theme.of(context).textTheme.bodySmall)
//                               ],
//                             ),
//                             style: ElevatedButton.styleFrom(
//                               elevation: 0,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10)),
//                               primary: Colors.grey.withOpacity(0.5),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       margin: const EdgeInsets.symmetric(
//                           vertical: 6 * _scaleScreen),
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 12 * _scaleScreen,
//                           horizontal: 16 * _scaleScreen),
//                       decoration: BoxDecoration(
//                         borderRadius: Dimens.kBorderRadius,
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: const Offset(
//                                 0, 2), // changes position of shadow
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           ListTile(
//                             leading: Image.asset("assets/breakfast.png"),
//                             title: Text(
//                               'Breakfast',
//                               style: Theme.of(context).textTheme.bodySmall,
//                             ),
//                             contentPadding: EdgeInsets.zero,
//                             trailing: IconButton(
//                               onPressed: () {},
//                               icon: Icon(
//                                 Icons.add_circle,
//                                 color: Theme.of(context).primaryColor,
//                                 size: 30 * _scaleScreen,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       margin: const EdgeInsets.symmetric(
//                           vertical: 6 * _scaleScreen),
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 12 * _scaleScreen,
//                           horizontal: 16 * _scaleScreen),
//                       decoration: BoxDecoration(
//                         borderRadius: Dimens.kBorderRadius,
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: const Offset(
//                                 0, 2), // changes position of shadow
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           ListTile(
//                             leading: Image.asset("assets/lunch.png"),
//                             title: Text(
//                               'Lunch',
//                               style: Theme.of(context).textTheme.bodySmall,
//                             ),
//                             contentPadding: EdgeInsets.zero,
//                             trailing: IconButton(
//                               onPressed: () {},
//                               icon: Icon(
//                                 Icons.add_circle,
//                                 color: Theme.of(context).primaryColor,
//                                 size: 30 * _scaleScreen,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       margin: const EdgeInsets.symmetric(
//                           vertical: 6 * _scaleScreen),
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 12 * _scaleScreen,
//                           horizontal: 16 * _scaleScreen),
//                       decoration: BoxDecoration(
//                         borderRadius: Dimens.kBorderRadius,
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: const Offset(
//                                 0, 2), // changes position of shadow
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           ListTile(
//                             leading: Image.asset("assets/dinner.png"),
//                             title: Text(
//                               'Dinner',
//                               style: Theme.of(context).textTheme.bodySmall,
//                             ),
//                             contentPadding: EdgeInsets.zero,
//                             trailing: IconButton(
//                               onPressed: () {},
//                               icon: Icon(
//                                 Icons.add_circle,
//                                 color: Theme.of(context).primaryColor,
//                                 size: 30 * _scaleScreen,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
