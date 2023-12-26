import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  final List<Color> supportColors;
  final int activeIndex;
  final ValueChanged<int> onSelect;

  const ColorSelector({
    Key? key,
    required this.supportColors,
    required this.activeIndex,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Wrap(
        children: List.generate(supportColors.length, _buildByIndex),
      ),
    );
  }

  Widget _buildByIndex(int index) {
    bool isSelect = index == activeIndex;
    return GestureDetector(
      onTap: () => onSelect(index),
      child: Container(
        padding: EdgeInsets.all(2),
        width: 28,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: isSelect ? Border.all(color: Colors.blue) : null,
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: supportColors[index],
          ),
        ),
      ),
    );
  }
}
