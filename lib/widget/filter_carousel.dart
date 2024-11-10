import 'package:flutter/material.dart';
import 'filter_selector.dart';

@immutable
class PhotoFilterCarousel extends StatelessWidget {
  const PhotoFilterCarousel({Key? key, required this.onFilterChanged}) : super(key: key);

  final ValueChanged<Color> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    final filters = [
      Colors.transparent,
      Colors.red.withOpacity(0.2),
      Colors.green.withOpacity(0.2),
      Colors.blue.withOpacity(0.2),
      Colors.yellow.withOpacity(0.2),
      Colors.purple.withOpacity(0.2),
      Colors.pink.withOpacity(0.2),
    ];

    return FilterSelector(
      filters: filters,
      onFilterChanged: onFilterChanged,
    );
  }
}
