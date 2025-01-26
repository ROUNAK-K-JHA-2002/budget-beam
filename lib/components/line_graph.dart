import 'package:budgetbeam/components/banner_ads_widget.dart';
import 'package:budgetbeam/components/dropdown.dart';
import 'package:budgetbeam/entity/expense_entity.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LineGraph extends StatefulWidget {
  final List<ExpenseEntity> expenses;

  const LineGraph({required this.expenses, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LineGraphState createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {
  String selectedTimeGranularity = 'Weekdays';
  String selectedType = 'Overall';
  List<Map<String, dynamic>> chartData = [];
  DateTime currentPeriod = DateTime.now();
  ValueNotifier<int> selectedIndex = ValueNotifier(0);
  @override
  void initState() {
    super.initState();
    _updateChartData();
  }

  // Update chart data based on filters
  void _changePeriod(int offset) {
    setState(() {
      if (selectedTimeGranularity == 'Weekdays') {
        // Adjust currentPeriod to the start of the week
        currentPeriod = currentPeriod.add(Duration(days: 7 * offset));
        currentPeriod =
            currentPeriod.subtract(Duration(days: currentPeriod.weekday - 1));
      } else if (selectedTimeGranularity == 'Months') {
        currentPeriod =
            DateTime(currentPeriod.year, currentPeriod.month + offset);
      } else {
        currentPeriod = DateTime(currentPeriod.year + offset);
      }
      _updateChartData();
    });
  }

  void _updateChartData() {
    List<ExpenseEntity> filteredExpenses = widget.expenses;

    if (selectedType != 'Overall') {
      filteredExpenses = filteredExpenses
          .where((e) => e.type == selectedType.toLowerCase())
          .toList();
    }

    Map<String, int> groupedData = {};
    filteredExpenses.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));

    List<String> keys;
    if (selectedTimeGranularity == 'Weekdays') {
      keys = [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday'
      ];

      // Filter expenses for the current week
      DateTime startOfWeek = currentPeriod;
      DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
      filteredExpenses = filteredExpenses.where((expense) {
        return expense.dateCreated
                .isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
            expense.dateCreated
                .isBefore(endOfWeek.add(const Duration(days: 1)));
      }).toList();
    } else if (selectedTimeGranularity == 'Months') {
      int daysInMonth =
          DateTime(currentPeriod.year, currentPeriod.month + 1, 0).day;
      keys = List.generate(daysInMonth, (index) => (index + 1).toString());

      // Filter expenses for the current month
      filteredExpenses = filteredExpenses.where((expense) {
        return expense.dateCreated.year == currentPeriod.year &&
            expense.dateCreated.month == currentPeriod.month;
      }).toList();
    } else {
      int currentYear = DateTime.now().year;
      keys = List.generate(5, (index) => (currentYear - 4 + index).toString());
    }

    for (var key in keys) {
      groupedData[key] = 0;
    }

    for (var expense in filteredExpenses) {
      String key;
      if (selectedTimeGranularity == 'Weekdays') {
        key = DateFormat('EEEE').format(expense.dateCreated);
      } else if (selectedTimeGranularity == 'Months') {
        key = expense.dateCreated.day.toString();
      } else {
        key = DateFormat('yyyy').format(expense.dateCreated);
      }
      if (groupedData.containsKey(key)) {
        groupedData[key] = (groupedData[key] ?? 0) + expense.amount;
      }
    }

    setState(() {
      chartData = groupedData.entries
          .map((entry) => {'time': entry.key, 'value': entry.value})
          .toList();
    });
  }

  String _getCurrentPeriodLabel() {
    if (selectedTimeGranularity == 'Weekdays') {
      DateTime startOfWeek =
          currentPeriod.subtract(Duration(days: currentPeriod.weekday - 1));
      DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
      return '${DateFormat('MMM d').format(startOfWeek)} - ${DateFormat('MMM d').format(endOfWeek)}';
    } else if (selectedTimeGranularity == 'Months') {
      return DateFormat('MMMM yyyy').format(currentPeriod);
    } else {
      return currentPeriod.year.toString();
    }
  }

  final typeOptions = [
    {'text': 'Overall', 'icon': Icons.all_inclusive, 'color': Colors.blue},
    {'text': 'Spend', 'icon': Icons.money_off, 'color': Colors.red},
    {'text': 'Income', 'icon': Icons.attach_money, 'color': Colors.green},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => _changePeriod(-1),
                  ),
                  Text(_getCurrentPeriodLabel()),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () => _changePeriod(1),
                  ),
                ],
              ),
              SizedBox(
                width: 30.w,
                child: CustomDropdown(
                  isCompact: true,
                  options: const [
                    {
                      'text': 'Weekdays',
                      'icon': Icons.calendar_today,
                      'color': Colors.orange
                    },
                    {
                      'text': 'Months',
                      'icon': Icons.calendar_view_month,
                      'color': Colors.purple
                    },
                    {
                      'text': 'Years',
                      'icon': Icons.date_range,
                      'color': Colors.teal
                    },
                  ],
                  initialValue: selectedTimeGranularity,
                  onChanged: (value) {
                    setState(() {
                      selectedTimeGranularity = value;
                      _updateChartData();
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          SizedBox(
            width: 100.w,
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 5.w,
              children: List<Widget>.generate(
                typeOptions.length,
                (int index) {
                  return ValueListenableBuilder(
                      valueListenable: selectedIndex,
                      builder: (context, value, child) {
                        return InputChip(
                          labelPadding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 0.2.h),
                          label: Text(typeOptions[index]['text'] as String),
                          selected: selectedIndex.value == index,
                          backgroundColor: Colors.white,
                          elevation: 2,
                          showCheckmark: false,
                          onSelected: (bool selected) {
                            selectedIndex.value = index;
                            selectedType = typeOptions[index]['text'] as String;
                            _updateChartData();
                          },

                          // onDeleted: () {
                        );
                      });
                },
              ).toList(),
            ),
          ),
          SizedBox(height: 1.h),
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
                    axes: [
                      Defaults.horizontalAxis,
                      Defaults.verticalAxis,
                    ],
                  ),
          ),
          SizedBox(height: 1.h),
          const BannerAdsWidget(),
          SizedBox(height: 1.h),
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
                    marks: [IntervalMark()],
                    data: chartData,
                    coord: RectCoord(),
                    variables: {
                      'time': Variable(
                        // scale: Scale(),
                        accessor: (Map map) => map['time'] as String,
                      ),
                      'value': Variable(
                        accessor: (Map map) => map['value'] as num,
                      ),
                    },
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
