import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_timer/core/context_extension.dart';

const _step = 0.5;
const _maxValue = 50.0;

class RatioWidget extends StatefulWidget {
  const RatioWidget({
    Key? key,
    required this.title,
    required this.initialValue,
    required this.onValueChanged,
    this.flex = 1,
  }) : super(key: key);

  final String title;
  final double initialValue;
  final ValueChanged<double> onValueChanged;
  final int flex;

  @override
  State<RatioWidget> createState() => _RatioWidgetState();
}

class _RatioWidgetState extends State<RatioWidget> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    _controller.text = widget.initialValue.toString();
    _focusNode.addListener(_focusNodeListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.removeListener(_focusNodeListener);
    _focusNode.dispose();
    super.dispose();
  }

  void _focusNodeListener() {
    if (_focusNode.hasFocus) {
      _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
    }
  }

  double get currentValue => double.parse(_controller.text);
  set currentValue(double newValue) => _controller.text = newValue.toString();

  void _decrease() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (currentValue > _step) {
      final r = currentValue % _step;
      currentValue = r == 0 ? currentValue - _step : (currentValue ~/ _step) * _step;
      widget.onValueChanged(currentValue);
    }
  }

  void _increase() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (currentValue < _maxValue) {
      final r = currentValue % _step;
      currentValue = (r == 0 ? currentValue : (currentValue ~/ _step) * _step) + _step;
      widget.onValueChanged(currentValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            maxLines: 1,
          ),
          const SizedBox(height: 8),
          Container(
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: context.color.borderColor),
            ),
            alignment: Alignment.center,
            child: Row(
              children: [
                IconButton(
                  onPressed: _decrease,
                  icon: const Icon(CupertinoIcons.minus_circle),
                ),
                Expanded(
                  child: CupertinoTextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyLarge,
                    cursorColor: context.color.mainText,
                    decoration: const BoxDecoration(),
                    onChanged: (str) {
                      if (str.isNotEmpty) widget.onValueChanged(currentValue);
                    },
                    onTapOutside: (_) {
                      if (_controller.text.isEmpty) _controller.text = widget.initialValue.toString();
                    },
                    inputFormatters: [
                      MaxValueFormatter(_maxValue),
                      DecimalTextInputFormatter(decimalRange: 1),
                      ReplaceCommaFormatter(),
                    ],
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                IconButton(
                  onPressed: _increase,
                  icon: const Icon(CupertinoIcons.add_circled),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange}) : assert(decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    String value = newValue.text;

    if (value.contains(".") && value.substring(value.indexOf(".") + 1).length > decimalRange) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    } else if (value == ".") {
      truncated = "0.";

      newSelection = newValue.selection.copyWith(
        baseOffset: math.min(truncated.length, truncated.length + 1),
        extentOffset: math.min(truncated.length, truncated.length + 1),
      );
    }

    return TextEditingValue(
      text: truncated,
      selection: newSelection,
      composing: TextRange.empty,
    );
  }
}

class ReplaceCommaFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.replaceAll(',', '.'),
      selection: TextSelection.collapsed(offset: newValue.text.length),
    );
  }
}

class MaxValueFormatter extends TextInputFormatter {
  MaxValueFormatter(this.maxValue);
  final double maxValue;
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newValueDouble = double.tryParse(newValue.text);
    if (newValueDouble == null || newValueDouble <= maxValue) return newValue;

    return TextEditingValue(
      text: maxValue.toString(),
      selection: newValue.selection,
    );
  }
}
