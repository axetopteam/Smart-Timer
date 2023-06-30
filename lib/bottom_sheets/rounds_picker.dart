import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_timer/core/context_extension.dart';

class RoundsPicker extends StatefulWidget {
  static Future<int?> showRoundsPicker(
    BuildContext context, {
    required String title,
    required int initialValue,
    required List<int> range,
  }) {
    return showCupertinoModalBottomSheet<int>(
      context: context,
      topRadius: const Radius.circular(20),
      builder: (ctx) => RoundsPicker(
        title: title,
        initialValue: initialValue,
        range: range,
      ),
    );
  }

  const RoundsPicker({
    Key? key,
    required this.title,
    required this.initialValue,
    required this.range,
  }) : super(key: key);

  final String title;
  final int initialValue;
  final List<int> range;

  @override
  State<RoundsPicker> createState() => _RoundsPickerState();
}

class _RoundsPickerState extends State<RoundsPicker> {
  late int selectedIndex;

  late final FixedExtentScrollController _controller;

  @override
  void initState() {
    selectedIndex = widget.range.indexOf(widget.initialValue);
    _controller = FixedExtentScrollController(initialItem: selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final safeOffset = mq.viewPadding;
    final bottomPadding = max(safeOffset.bottom, 34.0);

    return Container(
      height: mq.size.height * 0.8,
      decoration: BoxDecoration(
        color: context.color.bottomSheetBackgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text(
            'Rounds',
            style: context.textTheme.headline3,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: CupertinoPicker(
              looping: true,
              useMagnifier: true,
              magnification: 1.2,
              backgroundColor: context.color.bottomSheetBackgroundColor,
              scrollController: _controller,
              onSelectedItemChanged: (value) {
                selectedIndex = value;
              },
              itemExtent: 40,
              children: widget.range
                  .map(
                    (round) => Center(
                      child: Text(
                        '$round',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButtonTheme(
              data: context.buttonThemes.popupButtonTheme,
              child: ElevatedButton(
                child: const Text(
                  'Confirm',
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          SizedBox(height: bottomPadding),
          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }
}
