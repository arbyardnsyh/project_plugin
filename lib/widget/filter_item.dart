import 'package:flutter/material.dart';

@immutable
class FilterItem extends StatelessWidget {
  const FilterItem({
    Key? key,
    required this.color,
    required this.onFilterSelected,
  }) : super(key: key);

  final Color color;
  final VoidCallback onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFilterSelected,
      child: Container(
        width: 80,
        height: 80,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}
