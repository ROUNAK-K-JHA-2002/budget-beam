import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:budgetbeam/entity/expense_entity.dart';

class PieChartGraph extends StatefulWidget {
  final List<ExpenseEntity> expenses;

  const PieChartGraph({required this.expenses, super.key});

  @override
  _PieChartGraphState createState() => _PieChartGraphState();
}

class _PieChartGraphState extends State<PieChartGraph> {
  String selectedTimeGranularity = 'Weekdays';

  List<Map<String, dynamic>> getChartData() {
    Map<String, int> groupedData = {};

    for (var expense in widget.expenses) {
      String key;
      if (selectedTimeGranularity == 'Weekdays') {
        key = DateFormat('EEEE').format(expense.dateCreated);
      } else if (selectedTimeGranularity == 'Months') {
        key = DateFormat('MMM').format(expense.dateCreated);
      } else {
        key = DateFormat('yyyy').format(expense.dateCreated);
      }

      groupedData[key] = (groupedData[key] ?? 0) + expense.amount;
    }

    return groupedData.entries
        .map((entry) => {'category': entry.key, 'amount': entry.value})
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedTimeGranularity,
              items: ['Weekdays', 'Months', 'Years']
                  .map((item) =>
                      DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedTimeGranularity = value;
                  });
                }
              },
            ),
            SizedBox(
              width: 100.w,
              height: 300,
              child: Chart(
                data: getChartData(),
                marks: [
                  LineMark(
                      // position: Varset('category') * Varset('amount'),
                      // color: ColorEncode(
                      //   variable: 'category',
                      //   values: [
                      //     Colors.blue
                      //   ], // Use a single color for simplicity
                      // ),
                      ),
                ],
                variables: {
                  'category': Variable(
                    accessor: (Map map) => map['category'] as String,
                  ),
                  'amount': Variable(
                    accessor: (Map map) => map['amount'] as num,
                  ),
                },
                coord: RectCoord(),
                axes: [
                  Defaults.horizontalAxis,
                  Defaults.verticalAxis,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
