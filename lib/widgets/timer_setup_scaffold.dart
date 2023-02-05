import 'dart:math';

import 'package:flutter/material.dart';
import 'start_button.dart';

class TimerSetupScaffold extends StatelessWidget {
  const TimerSetupScaffold({
    required this.color,
    required this.appBarTitle,
    required this.subtitle,
    required this.onStartPressed,
    required this.slivers,
    Key? key,
  }) : super(key: key);

  final Color color;
  final String appBarTitle;
  final String subtitle;
  final List<Widget> slivers;
  final void Function() onStartPressed;

  @override
  Widget build(BuildContext context) {
    final safeOffset = MediaQuery.of(context).viewPadding;
    final bommomPadding = max(safeOffset.bottom, 34.0);
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: false,
                title: Text(appBarTitle),
                pinned: true,
                backgroundColor: color,
                expandedHeight: 140.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(left: 94, bottom: 20),
                    child: Text(subtitle),
                  ),
                ),
              ),
              ...slivers,
              SliverToBoxAdapter(child: SizedBox(height: bommomPadding + 100))
            ],
          ),
          Positioned(
            right: 0,
            bottom: bommomPadding,
            child: StartButton(
              backgroundColor: color,
              onPressed: onStartPressed,
            ),
          ),
        ],
      ),
    );
  }
}
