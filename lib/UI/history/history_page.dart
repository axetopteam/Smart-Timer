import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:jiffy/jiffy.dart';
import 'package:smart_timer/core/context_extension.dart';

import 'history_state.dart';

@RoutePage<void>()
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

    return CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: Text('History'),
          heroTag: 'history',
        ),
        CupertinoSliverRefreshControl(
          onRefresh: () async {
            await state.loadMore(isRefresh: true);
          },
        ),
        Observer(
          builder: (context) {
            if (state.error != null) {
              return SliverFillRemaining(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Failed to load history',
                      style: context.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButtonTheme(
                      data: context.buttonThemes.paywallButtonTheme,
                      child: ElevatedButton(
                        onPressed: () => state.loadMore(isRefresh: true),
                        child: Text('Обновить'),
                      ),
                    )
                  ],
                ),
              );
            }
            final records = state.records;
            return SliverList.separated(
              itemCount: records.length,
              separatorBuilder: (ctx, index) => const Divider(height: 12, thickness: 2),
              itemBuilder: (ctx, index) {
                final record = records[index];
                final finishAt = Jiffy.parseFromDateTime(record.startAt.toLocal());
                return CupertinoListTile(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  title: Text(record.readbleName),
                  leading: DecoratedBox(
                    decoration: BoxDecoration(
                      color: record.timerType.workoutColor(context),
                      shape: BoxShape.circle,
                    ),
                    child: const SizedBox.expand(),
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${finishAt.Md}/${finishAt.format(pattern: 'yy')}'),
                      Text(finishAt.jm),
                    ],
                  ),
                );
              },
            );
          },
        ),
        SliverToBoxAdapter(child: SizedBox(height: bottomPadding + 20)),
      ],
    );
  }
}
