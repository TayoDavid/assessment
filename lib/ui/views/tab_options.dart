import 'package:assessment/data/enums/task_option.dart';
import 'package:assessment/resources/utils/extensions.dart';
import 'package:flutter/material.dart';

class TabOptions extends StatelessWidget {
  const TabOptions({
    super.key,
    required this.option,
    this.selected = false,
    required this.onSelected,
  });

  final TaskOption option;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onSelected.withHaptic,
      child: AbsorbPointer(
        child: Container(
          margin: EdgeInsets.only(right: 20),
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: selected ? cs.primary : cs.secondary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              option.name.capitalize,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
