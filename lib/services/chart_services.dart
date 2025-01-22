import 'package:budgetbeam/entity/expense_entity.dart';

List<ExpenseEntity> filterByType(List<ExpenseEntity> expenses, String type) {
  if (type == "both") {
    return expenses;
  }
  return expenses.where((expense) => expense.type == type).toList();
}

Map<String, double> groupByTimeRange(
    List<ExpenseEntity> expenses, String timeRange) {
  final Map<String, double> groupedData = {};

  for (var expense in expenses) {
    String key;
    if (timeRange == 'weekly') {
      key = [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday'
      ][expense.dateCreated.weekday - 1];
    } else if (timeRange == 'monthly') {
      key = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ][expense.dateCreated.month - 1];
    } else if (timeRange == 'yearly') {
      key = expense.dateCreated.year.toString();
    } else {
      continue;
    }

    groupedData[key] = (groupedData[key] ?? 0) + expense.amount;
  }

  return groupedData;
}

class LineChartDataItem {
  final String xAxisLabels;
  final double yAxisValues;
  LineChartDataItem(this.xAxisLabels, this.yAxisValues);
}

List<LineChartDataItem> prepareLineChartDataItem(
    List<ExpenseEntity> expenses, String type, String timeRange) {
  final filteredData = filterByType(expenses, type);
  final groupedData = groupByTimeRange(filteredData, timeRange);

  return groupedData.entries
      .map((entry) => LineChartDataItem(entry.key, entry.value))
      .toList();
}
