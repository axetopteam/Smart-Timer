import 'package:flutter/cupertino.dart';
import 'package:smart_timer/application/application_theme.dart';
import 'package:smart_timer/widgets/main_button.dart';

class RoundsPicker extends StatefulWidget {
  static Future<int?> showRoundsPicker(
    BuildContext context, {
    required int initialValue,
    required List<int> range,
  }) {
    return showCupertinoModalPopup<int>(
      context: context,
      builder: (ctx) => RoundsPicker(
        initialValue: initialValue,
        range: range,
      ),
    );
  }

  const RoundsPicker({
    Key? key,
    required this.initialValue,
    required this.range,
  }) : super(key: key);

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
    return Container(
      color: CupertinoColors.systemGrey5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 200,
            child: CupertinoPicker(
              looping: true,
              useMagnifier: true,
              magnification: 1.2,
              backgroundColor: CupertinoColors.systemGrey5,
              scrollController: _controller,
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
              onSelectedItemChanged: (value) {
                selectedIndex = value;
              },
              itemExtent: 40,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: MainButton(
              child: const Text(
                'Ok',
                style: AppFonts.buttonTitle,
              ),
              color: CupertinoColors.activeBlue,
              onPressed: () {
                Navigator.of(context).pop(widget.range[selectedIndex]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
