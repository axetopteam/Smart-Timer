import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_timer/UI/favorites/favorites_page.dart';
import 'package:smart_timer/UI/history/history_page.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';

enum WorkoutsPageType {
  history,
  favorites;

  String get readbleName {
    switch (this) {
      case WorkoutsPageType.history:
        return LocaleKeys.history_title.tr();
      case WorkoutsPageType.favorites:
        return LocaleKeys.favorites_title.tr();
    }
  }
}

@RoutePage()
class WorkoutsPage extends StatefulWidget {
  const WorkoutsPage({super.key});

  @override
  State<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  var selectedPage = WorkoutsPageType.history;

  void _onTapSegmentController(WorkoutsPageType? newValue) {
    if (newValue != null) {
      setState(() {
        selectedPage = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final safeOffset = MediaQuery.of(context).padding;
    return Column(
      // headerSliverBuilder: (context, innerBoxIsScrolled) {
      //   return [
      //     SliverPadding(
      //       padding: EdgeInsets.fromLTRB(20, safeOffset.top, 20, 20),
      //       sliver: SliverToBoxAdapter(
      //         child: CupertinoSlidingSegmentedControl<WorkoutsPageType>(
      //           groupValue: selectedPage,
      //           children: Map.fromIterable(WorkoutsPageType.values, value: (type) => Text(type.readbleName)),
      //           onValueChanged: _onTapSegmentController,
      //         ),
      //       ),
      //     )
      //   ];
      // },
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, safeOffset.top + 20, 20, 20),
          child: CupertinoSlidingSegmentedControl<WorkoutsPageType>(
            groupValue: selectedPage,
            children:
                Map.fromIterable(WorkoutsPageType.values, value: (type) => SizedBox(child: Text(type.readbleName))),
            onValueChanged: _onTapSegmentController,
          ),
        ),
        Expanded(
          child: IndexedStack(
            index: selectedPage.index,
            children: const [
              HistoryPage(),
              FavouritesPage(),
            ],
          ),
        )
      ],
    );
  }
}
