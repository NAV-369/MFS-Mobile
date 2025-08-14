import 'package:flutter/material.dart';

class MiniBarChart extends StatelessWidget {
  final List<double> values;
  final Color barColor;
  final double maxHeight;

  const MiniBarChart({
    super.key,
    required this.values,
    this.barColor = Colors.white,
    this.maxHeight = 25,
  });

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) {
      return const SizedBox.shrink();
    }

    double maxValue = values.reduce((a, b) => a > b ? a : b);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: values.map((v) {
        double barHeight = (v / maxValue) * maxHeight;
        return Container(
          width: 6,
          height: barHeight,
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }).toList(),
    );
  }
}