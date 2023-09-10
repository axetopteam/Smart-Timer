import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_timer/core/context_extension.dart';
import 'package:smart_timer/core/localization/locale_keys.g.dart';

class SecondsPicker extends StatefulWidget {
  static final countdownSecondsList = List.generate(28, (index) => 3 + index);

  static Future<int?> show(
    BuildContext context, {
    required String title,
    int? initialValue,
    required List<int> range,
  }) {
    return showCupertinoModalBottomSheet<int?>(
      context: context,
      topRadius: const Radius.circular(20),
      builder: (ctx) => SecondsPicker(
        title: title,
        range: range,
        initialValue: initialValue ?? range.first,
      ),
    );
  }

  const SecondsPicker({
    Key? key,
    required this.title,
    required this.initialValue,
    required this.range,
  }) : super(key: key);

  final String title;
  final int initialValue;
  final List<int> range;

  @override
  State<SecondsPicker> createState() => _SecondsPickerState();
}

class _SecondsPickerState extends State<SecondsPicker> {
  late final FixedExtentScrollController _secondsController;

  @override
  void initState() {
    final initialIndex = widget.range.indexWhere((element) => element == widget.initialValue);

    _secondsController = FixedExtentScrollController(initialItem: initialIndex);

    super.initState();
  }

  @override
  void dispose() {
    _secondsController.dispose();

    super.dispose();
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
        children: [
          const SizedBox(height: 20),
          Text(
            widget.title,
            style: context.textTheme.displaySmall,
          ),
          const Spacer(),
          Expanded(
            flex: 8,
            child: Row(
              children: [
                Expanded(
                  child: CupertinoPicker(
                    useMagnifier: true,
                    magnification: 1,
                    diameterRatio: 20,
                    scrollController: _secondsController,
                    selectionOverlay: Center(
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.15),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 44),
                          child: Text(
                            LocaleKeys.second_shortest.tr(),
                            style: context.textTheme.headlineMedium,
                          ),
                        ),
                      ),
                    ),
                    onSelectedItemChanged: (value) {},
                    itemExtent: 70,
                    children: widget.range
                        .map(
                          (seconds) => Center(
                            child: Text(
                              '$seconds',
                              textAlign: TextAlign.center,
                              style: context.textTheme.headlineMedium,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButtonTheme(
              data: context.buttonThemes.popupButtonTheme,
              child: ElevatedButton(
                child: Text(
                  LocaleKeys.confirm.tr(),
                ),
                onPressed: () {
                  final seconds = widget.range[_secondsController.selectedItem];
                  Navigator.of(context).pop(seconds);
                },
              ),
            ),
          ),
          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }
}
