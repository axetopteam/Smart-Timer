import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_timer/core/context_extension.dart';

class RoundsWidget extends StatefulWidget {
  const RoundsWidget({
    Key? key,
    required this.title,
    required this.initialValue,
    required this.onValueChanged,
    this.flex = 1,
    this.unlimited = false,
  }) : super(key: key);

  final String title;
  final int initialValue;
  final ValueChanged<int> onValueChanged;
  final int flex;
  final bool unlimited;

  @override
  State<RoundsWidget> createState() => _RoundsWidgetState();
}

class _RoundsWidgetState extends State<RoundsWidget> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  final _unlimitedSymbol = '∞';

  @override
  void initState() {
    _controller.text = widget.unlimited ? _unlimitedSymbol : widget.initialValue.toString();
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

  int get currentValue => int.parse(_controller.text);
  set currentValue(int newValue) => _controller.text = newValue.toString();

  void _decrease() {
    if (currentValue > 1) {
      currentValue--;
      widget.onValueChanged(currentValue);
    }
  }

  void _increase() {
    currentValue++;
    widget.onValueChanged(currentValue);
  }

  @override
  void didUpdateWidget(covariant RoundsWidget oldWidget) {
    if (oldWidget.unlimited != widget.unlimited) {
      _controller.text = widget.unlimited ? _unlimitedSymbol : widget.initialValue.toString();
    }
    super.didUpdateWidget(oldWidget);
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
                if (!widget.unlimited)
                  IconButton(
                    onPressed: _decrease,
                    icon: const Icon(CupertinoIcons.minus_circle),
                  ),
                Expanded(
                  child: CupertinoTextField(
                    enabled: !widget.unlimited,
                    controller: _controller,
                    focusNode: _focusNode,
                    textAlign: TextAlign.center,
                    style: widget.unlimited
                        ? context.textTheme.bodyLarge?.copyWith(fontSize: 30)
                        : context.textTheme.bodyLarge,
                    cursorColor: context.color.mainText,
                    decoration: const BoxDecoration(),
                    onChanged: (str) {
                      if (str.isNotEmpty) widget.onValueChanged(currentValue);
                    },
                    onTapOutside: (_) {
                      if (_controller.text.isEmpty) _controller.text = widget.initialValue.toString();
                    },
                    maxLength: 3,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                  ),
                ),
                if (!widget.unlimited)
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
