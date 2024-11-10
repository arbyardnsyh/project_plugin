import 'package:flutter/material.dart';
import 'filter_item.dart';

@immutable
class FilterSelector extends StatelessWidget {
  const FilterSelector({
    Key? key,
    required this.filters,
    required this.onFilterChanged,
  }) : super(key: key);

  final List<Color> filters;
  final ValueChanged<Color> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return FilterItem(
            color: filters[index],
            onFilterSelected: () => onFilterChanged(filters[index]),
          );
        },
      ),
    );
  }
}
