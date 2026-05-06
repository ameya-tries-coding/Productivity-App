import 'package:flutter/material.dart';

class CustomHeatmap extends StatelessWidget {
  final Map<DateTime, int> data;
  final DateTime startDate;
  final DateTime endDate;

  const CustomHeatmap({
    super.key,
    required this.data,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    // Generate dates between startDate and endDate
    final List<DateTime> dates = [];
    DateTime current = DateTime(startDate.year, startDate.month, startDate.day);
    final end = DateTime(endDate.year, endDate.month, endDate.day);

    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      dates.add(current);
      current = current.add(const Duration(days: 1));
    }

    // Determine how many weeks we need to display
    // A standard github heatmap has days of the week on Y axis and weeks on X axis.
    // For simplicity, we can do a Wrap or a custom GridView.
    
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxSize = (constraints.maxWidth - 40) / 10; // roughly 10 boxes per row
        return Wrap(
          spacing: 4.0,
          runSpacing: 4.0,
          children: dates.map((date) {
            final count = data[date] ?? 0;
            return Tooltip(
              message: '${date.month}/${date.day}/${date.year}: $count completed',
              child: Container(
                width: boxSize,
                height: boxSize,
                decoration: BoxDecoration(
                  color: _getColor(count, context),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Color _getColor(int count, BuildContext context) {
    if (count == 0) return Colors.grey.withOpacity(0.1);
    final primary = Theme.of(context).primaryColor;
    if (count == 1) return primary.withOpacity(0.3);
    if (count == 2) return primary.withOpacity(0.6);
    if (count >= 3) return primary;
    return primary;
  }
}
