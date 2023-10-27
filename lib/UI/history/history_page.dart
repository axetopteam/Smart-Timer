import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

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
    state = context.read<HistoryState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LazyLoadScrollView(
        isLoading: false,
        onEndOfPage: () => state.loadMore(),
        child: Observer(builder: (context) {
          if (state.error != null) {
            return Text('Failed to load history');
          }
          final records = state.records;
          return ListView.separated(
            itemCount: records.length,
            separatorBuilder: (ctx, index) => const Divider(height: 12, thickness: 2),
            itemBuilder: (ctx, index) {
              final record = records[index];
              final finishAt = Jiffy.parseFromDateTime(record.finishAt.toLocal());
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
        }));
  }
}
