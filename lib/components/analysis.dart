import 'package:budgetbeam/components/dropdown.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:budgetbeam/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:budgetbeam/entity/expense_entity.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Analysis extends StatefulWidget {
  final List<ExpenseEntity> expenses;

  const Analysis({required this.expenses, super.key});

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  String selectedInterval = 'Day';
  String selectedType = 'Overall';
  String selectedTimeGranularity = 'Weekdays';
  List<Map<String, dynamic>> categoryData = [];
  DateTime currentPeriod = DateTime.now();
  ValueNotifier<int> selectedIndex = ValueNotifier(0);
  @override
  void initState() {
    super.initState();
    _updateCategoryData();
  }

  void _updateCategoryData() {
    List<ExpenseEntity> filteredExpenses = widget.expenses;

    if (selectedType != 'Overall') {
      filteredExpenses = filteredExpenses
          .where((e) => e.type == selectedType.toLowerCase())
          .toList();
    }

    if (selectedInterval == 'Weekdays') {
      DateTime startOfWeek =
          currentPeriod.subtract(Duration(days: currentPeriod.weekday - 1));
      DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
      filteredExpenses = filteredExpenses.where((expense) {
        return expense.dateCreated
                .isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
            expense.dateCreated
                .isBefore(endOfWeek.add(const Duration(days: 1)));
      }).toList();
    } else if (selectedInterval == 'Months') {
      filteredExpenses = filteredExpenses.where((expense) {
        return expense.dateCreated.year == currentPeriod.year &&
            expense.dateCreated.month == currentPeriod.month;
      }).toList();
    } else {
      filteredExpenses = filteredExpenses.where((expense) {
        return expense.dateCreated.year == currentPeriod.year;
      }).toList();
    }

    Map<String, double> categoryTotals = {};

    for (var expense in filteredExpenses) {
      if (categoryTotals.containsKey(expense.category)) {
        categoryTotals[expense.category] =
            (categoryTotals[expense.category] ?? 0.0) + expense.amount;
      } else {
        categoryTotals[expense.category] = expense.amount.toDouble();
      }
    }

    setState(() {
      categoryData = categoryTotals.entries
          .map((entry) => {'category': entry.key, 'value': entry.value})
          .toList();
      categoryData.sort((a, b) => b['value'].compareTo(a['value']));
    });
  }

  void _changePeriod(int offset) {
    setState(() {
      if (selectedInterval == 'Weekdays') {
        currentPeriod = currentPeriod.add(Duration(days: 7 * offset));
        currentPeriod =
            currentPeriod.subtract(Duration(days: currentPeriod.weekday - 1));
      } else if (selectedInterval == 'Months') {
        currentPeriod =
            DateTime(currentPeriod.year, currentPeriod.month + offset);
      } else {
        currentPeriod = DateTime(currentPeriod.year + offset);
      }
      _updateCategoryData();
    });
  }

  Color _getCategoryColor(String category) {
    return categories.firstWhere(
      (c) => c['text'] == category,
      orElse: () => {'color': Colors.grey},
    )['color'] as Color;
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
    return Column(
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
                    _updateCategoryData();
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        ValueListenableBuilder(
            valueListenable: selectedIndex,
            builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      selectedIndex.value = 0;
                      selectedType = typeOptions[0]['text'] as String;
                      _updateCategoryData();
                    },
                    child: Container(
                      width: 29.w,
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selectedType == "Overall"
                            ? kPrimaryColor.withOpacity(0.12)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: kPrimaryColor,
                          width: 0.5,
                        ),
                      ),
                      child: const Text("Overall"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectedIndex.value = 1;
                      selectedType = typeOptions[1]['text'] as String;
                      _updateCategoryData();
                    },
                    child: Container(
                      width: 29.w,
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selectedType == "Spend"
                            ? kPrimaryColor.withOpacity(0.12)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: kPrimaryColor,
                          width: 0.5,
                        ),
                      ),
                      child: const Text("Spend"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectedIndex.value = 2;
                      selectedType = typeOptions[2]['text'] as String;
                      _updateCategoryData();
                    },
                    child: Container(
                      width: 29.w,
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selectedType == "Income"
                            ? kPrimaryColor.withOpacity(0.12)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: kPrimaryColor,
                          width: 0.5,
                        ),
                      ),
                      child: const Text("Income"),
                    ),
                  ),
                ],
              );
            }),
        SizedBox(height: 1.h),
        Container(
          height: 30.h,
          child: categoryData.isEmpty
              ? const Center(child: Text('No data available'))
              : Chart(
                  marks: [
                    IntervalMark(
                      label: LabelEncode(
                          encoder: (tuple) =>
                              Label(tuple['category'].toString())),
                      shape: ShapeEncode(
                          value: RectShape(
                              borderRadius: BorderRadius.circular(10))),
                      color: ColorEncode(
                        variable: 'category',
                        values: categoryData.length > 1
                            ? categoryData
                                .map((data) =>
                                    _getCategoryColor(data['category']))
                                .toList()
                            : [
                                _getCategoryColor(
                                    categoryData.first['category']),
                                _getCategoryColor(
                                    categoryData.first['category'])
                              ],
                      ),
                    )
                  ],
                  data: categoryData,
                  variables: {
                    'category': Variable(
                      accessor: (Map map) => map['category'] as String,
                    ),
                    'value': Variable(
                      accessor: (Map map) => map['value'] as num,
                      scale: LinearScale(min: 0, marginMax: 0.1),
                    ),
                  },
                  coord: PolarCoord(startRadius: 0.15),
                ),
        ),
        // List of categories with line bar indicators
        Expanded(
          child: ListView.builder(
            itemCount: categoryData.length,
            itemBuilder: (context, index) {
              final category = categoryData[index];
              final color = _getCategoryColor(category['category']);
              final icon = categories.firstWhere(
                (c) => c['text'] == category['category'],
                orElse: () => {'icon': Icons.error},
              )['icon'] as IconData;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                margin: EdgeInsets.symmetric(vertical: 1.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.1),
                      blurRadius: 5,
                    )
                  ],
                ),
                width: 90.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                        margin: EdgeInsets.only(right: 2.w),
                        alignment: Alignment.center,
                        height: 5.h,
                        width: 5.h,
                        decoration: BoxDecoration(
                            color: categories.firstWhere(
                              (element) {
                                return category['category'] == element['text'];
                              },
                              orElse: () => {'color': kPrimaryColor},
                            )['color'][100],
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(
                          icon,
                          color: color,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(category['category']),
                              SizedBox(width: 2.w),
                              Padding(
                                padding: EdgeInsets.only(right: 2.w),
                                child: Text(category['value'].toString()),
                              )
                            ],
                          ),
                          SizedBox(height: 1.h),
                          LinearProgressIndicator(
                            borderRadius: BorderRadius.circular(10),
                            minHeight: 0.6.h,
                            color: color,
                            value:
                                category['value'] / categoryData.first['value'],
                          ),
                        ],
                      ))
                    ])
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
