import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:jiffy/jiffy.dart';
import 'package:smart_timer/UI/widgets/workout_filter_chip.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';
import 'package:smart_timer/routes/router.dart';

import 'history_state.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late final HistoryState state;
  @override
  void initState() {
    state = GetIt.I<HistoryState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20, bottom: 8),
          child: Align(
            alignment: Alignment.centerRight,
            child: Observer(builder: (context) {
              return WorkoutFilterChip(
                selectedType: state.selectedType,
                onSelect: state.selectType,
              );
            }),
          ),
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              CupertinoSliverRefreshControl(
                onRefresh: () async {
                  await state.loadMore(isRefresh: true);
                },
              ),
              Observer(
                builder: (context) {
                  final records = state.records;

                  if (records.isEmpty && state.error != null) {
                    return SliverFillRemaining(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.history_error.tr(),
                            style: context.textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButtonTheme(
                            data: context.buttonThemes.paywallButtonTheme,
                            child: ElevatedButton(
                              onPressed: () => state.loadMore(isRefresh: true),
                              child: Text(LocaleKeys.repeat.tr()),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  if (records.isEmpty) {
                    return SliverFillRemaining(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 40, 120),
                        child: Align(
                          child: Text(
                            LocaleKeys.history_empty.tr(),
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    );
                  }
                  return SliverList.separated(
                    itemCount: records.length + (state.canLoadMore ? 1 : 0),
                    separatorBuilder: (ctx, index) => const Divider(height: 2, thickness: 2),
                    itemBuilder: (ctx, index) {
                      if (index == records.length) {
                        state.loadMore();
                        return const CircularProgressIndicator.adaptive();
                      }
                      final record = records[index];
                      final startAt = Jiffy.parseFromDateTime(record.startAt.toLocal());
                      return Slidable(
                        key: ValueKey(record.id),
                        endActionPane: ActionPane(
                          dismissible: DismissiblePane(onDismissed: () {
                            state.deleteRecord(record.id);
                          }),
                          extentRatio: .25,
                          motion: const DrawerMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (_) {
                                state.deleteRecord(record.id);
                              },
                              backgroundColor: context.color.warning,
                              foregroundColor: Colors.white,
                              icon: CupertinoIcons.delete,
                            ),
                          ],
                        ),
                        child: CupertinoListTile(
                          onTap: () => context.router.push(WorkoutDetailsRoute(record: record)),
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          title: Text(record.readbleName),
                          leading: DecoratedBox(
                            decoration: BoxDecoration(
                              color: record.timerType.workoutColor(context),
                              shape: BoxShape.circle,
                            ),
                            child: const SizedBox.expand(),
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('${startAt.toLocal().Md}.${startAt.toLocal().format(pattern: 'yy')}'),
                              Text(startAt.toLocal().jm),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              SliverToBoxAdapter(child: SizedBox(height: bottomPadding + 20)),
            ],
          ),
        ),
      ],
    );
  }
}
