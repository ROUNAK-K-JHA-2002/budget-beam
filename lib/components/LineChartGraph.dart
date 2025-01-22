// import 'package:budgetbeam/services/chart_services.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class ExpenseLineChart extends StatelessWidget {
//   final List<LineChartDataItem> data;
//   final List<String> xLabels; // Add xLabels here for string x-axis
//   final String yLabel;

//   const ExpenseLineChart({
//     Key? key,
//     required this.data,
//     required this.xLabels,
//     required this.yLabel,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       LineChartData(
//         titlesData: FlTitlesData(
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: (value, meta) {
//                 final index = value.toInt();
//                 if (index < 0 || index >= xLabels.length) {
//                   return const SizedBox.shrink();
//                 }
//                 return Text(
//                   xLabels[index], // Use the corresponding string label
//                   style: const TextStyle(fontSize: 10),
//                   textAlign: TextAlign.center,
//                 );
//               },
//             ),
//           ),
//           leftTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: (value, meta) => Text(
//                 value.toInt().toString(),
//                 style: const TextStyle(fontSize: 12),
//               ),
//             ),
//           ),
//         ),
//         gridData: const FlGridData(show: true),
//         borderData: FlBorderData(show: true),
//         lineBarsData: [
//           LineChartBarData(
//             spots:
//                 data.map((entry) => FlSpot(20.0, entry.yAxisValues)).toList(),
//             isCurved: true,
//             barWidth: 4,
//             // color: Colors.blue,
//             // belowBarData:
//             //     BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
//           ),
//         ],
//       ),
//     );
//   }
// }
