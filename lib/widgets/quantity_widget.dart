import 'package:flutter/material.dart';
import 'package:smart_timer/widgets/value_container.dart';

class QuantityWidget extends StatelessWidget {
  const QuantityWidget({
    Key? key,
    required this.title,
    required this.quantity,
    required this.onTap,
    this.flex = 1,
  }) : super(key: key);

  final String title;
  final int quantity;
  final VoidCallback onTap;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onTap,
            child: ValueContainer(
              quantity.toString(),
            ),
          )
        ],
      ),
    );
  }
}
