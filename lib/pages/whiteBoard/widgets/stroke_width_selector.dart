import 'package:flutter/material.dart';

class StrokeWidthSelector extends StatelessWidget {
  final List<double> supportStrokeWidths;
  final int activeIndex;
  final Color color;
  final ValueChanged<int> onSelect;

  const StrokeWidthSelector({
    Key? key,
    required this.supportStrokeWidths,
    required this.color,
    required this.activeIndex,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          supportStrokeWidths.length,
          _buildByIndex,
        ),
      ),
    );
  }

  Widget _buildByIndex(int index) {
    bool isSelect = index == activeIndex;
    return GestureDetector(
      onTap: () => onSelect(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        width: 70,
        height: 18,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: isSelect ? Border.all(color: Colors.blue) : null,
        ),
        child: Container(
          width: 50,
          color: color,
          height: supportStrokeWidths[index],
        ),
      ),
    );
  }
}
