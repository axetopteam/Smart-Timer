import 'package:flutter/material.dart';
import 'package:smart_timer/widgets/value_container.dart';

class QuantityWidget extends StatelessWidget {
  const QuantityWidget({
    Key? key,
    required this.title,
    required this.quantity,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final int quantity;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: ValueContainer(
            quantity.toString(),
            width: 150,
          ),
        )
      ],
    );
  }
}
