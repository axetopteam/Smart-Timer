import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';

@RoutePage<void>()
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('History'));
  }
}
