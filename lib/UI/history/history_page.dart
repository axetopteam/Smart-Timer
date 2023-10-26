import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_timer/sdk/sdk_service.dart';

@RoutePage<void>()
class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GetIt.I<SdkService>().fetchHistory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data?.toString());
          }
          return Center(child: Text('History'));
        });
  }
}
