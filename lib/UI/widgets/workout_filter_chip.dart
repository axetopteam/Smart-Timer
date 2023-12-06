import 'package:flutter/material.dart';
import 'package:smart_timer/UI/timer/timer_type.dart';
import 'package:smart_timer/core/context_extension.dart';

class WorkoutFilterChip extends StatefulWidget {
  const WorkoutFilterChip({required this.selectedType, required this.onSelect, super.key});

  @override
  State<WorkoutFilterChip> createState() => _WorkoutFilterChipState();

  final TimerType? selectedType;
  final void Function(TimerType? type) onSelect;
}

class _WorkoutFilterChipState extends State<WorkoutFilterChip> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      position: PopupMenuPosition.under,
      constraints: const BoxConstraints(maxWidth: 160),
      offset: const Offset(0, 4),
      padding: EdgeInsets.zero,
      child: Chip(
        label: Text(
          widget.selectedType?.readbleName ?? 'All',
        ),
      ),
      itemBuilder: (BuildContext context) {
        return [
          _buildPopupMenuItem(
            null,
            onTap: () async {
              widget.onSelect(null);
            },
          ),
          ...TimerType.values.map(
            (e) => _buildPopupMenuItem(
              e,
              onTap: () async {
                widget.onSelect(e);
              },
            ),
          )
        ];
      },
    );
  }

  PopupMenuItem _buildPopupMenuItem(
    TimerType? type, {
    void Function()? onTap,
  }) {
    return PopupMenuItem<TimerType>(
      value: type,
      onTap: onTap,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        type?.readbleName ?? 'All',
        style: context.textTheme.bodyMedium,
      ),
    );
  }
}
