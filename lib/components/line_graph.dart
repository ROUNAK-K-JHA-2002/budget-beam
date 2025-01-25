import 'dart:async';

import 'package:budgetbeam/entity/expense_entity.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LineGraph extends StatefulWidget {
  final List<ExpenseEntity> expenses;

  const LineGraph({required this.expenses, super.key});

  @override
  _LineGraphState createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {
  String selectedTimeGranularity = 'Weekdays';
  String selectedType = 'Overall';
  List<Map<String, dynamic>> chartData = [];

  @override
  void initState() {
    super.initState();
    _updateChartData();
  }

  // Update chart data based on filters
  void _updateChartData() {
    List<ExpenseEntity> filteredExpenses = widget.expenses;

    if (selectedType != 'Overall') {
      filteredExpenses =
          filteredExpenses.where((e) => e.type == selectedType).toList();
    }

    Map<String, int> groupedData = {};
    filteredExpenses.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));

    for (var expense in filteredExpenses) {
      String key;

      if (selectedTimeGranularity == 'Weekdays') {
        key = DateFormat('EEEE').format(expense.dateCreated); // Weekday name
      } else if (selectedTimeGranularity == 'Months') {
        key =
            DateFormat('MMM').format(expense.dateCreated); // Month abbreviation
      } else {
        key = DateFormat('yyyy').format(expense.dateCreated); // Year
      }

      groupedData[key] = (groupedData[key] ?? 0) + expense.amount;
    }

    setState(() {
      chartData = groupedData.entries
          .map((entry) => {'time': entry.key, 'value': entry.value})
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Text('Line Graph', style: TextStyle(fontSize: 20.sp))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      _updateChartData();
                    });
                  }
                },
              ),
              DropdownButton<String>(
                value: selectedType,
                items: ['Overall', 'spend', 'income']
                    .map((item) =>
                        DropdownMenuItem(value: item, child: Text(item)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedType = value;
                      _updateChartData();
                    });
                  }
                },
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                  )
                ],
                borderRadius: BorderRadius.circular(10)),
            height: 30.h,
            width: 100.w,
            child: chartData.isEmpty
                ? const Center(child: Text('No data available'))
                : Chart(
                    marks: [LineMark()],
                    data: chartData,
                    coord: RectCoord(),
                    variables: {
                      'time': Variable(
                        accessor: (Map map) => map['time'] as String,
                      ),
                      'value': Variable(
                        accessor: (Map map) => map['value'] as num,
                      ),
                    },
                    // elements: [
                    //   LineElement(
                    //     shape: ShapeAttr(value: BasicLineShape(smooth: true)),
                    //     color: ColorAttr(value: Colors.blue),
                    //     size: SizeAttr(value: 2),
                    //   ),
                    //   PointElement(
                    //     size: SizeAttr(value: 6),
                    //     color: ColorAttr(value: Colors.blue),
                    //   ),
                    // ],
                    axes: [
                      Defaults.horizontalAxis,
                      Defaults.verticalAxis,
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
