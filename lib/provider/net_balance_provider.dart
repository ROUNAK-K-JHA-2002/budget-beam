import 'package:budgetbeam/entity/expense_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NetBalanceState {
  final int netBalance;
  final int netIncome;
  final int netSpend;
  final int todaysExpense;

  NetBalanceState({
    required this.netBalance,
    required this.netIncome,
    required this.netSpend,
    required this.todaysExpense,
  });
}

class NetBalanceNotifier extends StateNotifier<NetBalanceState> {
  NetBalanceNotifier()
      : super(NetBalanceState(
            netBalance: 0, netIncome: 0, netSpend: 0, todaysExpense: 0));

  void calculateNetBalance(List<ExpenseEntity> expenses) {
    int netIncome = 0;
    int netSpend = 0;
    int netBalance = 0;
    int todaysExpense = 0;

    DateTime now = DateTime.now();
    DateTime firstDayOfCurrentMonth = DateTime(now.year, now.month, 1);
    DateTime lastDayOfCurrentMonth =
        DateTime(now.year, now.month + 1, 1).subtract(const Duration(days: 1));
    DateTime startOfToday = DateTime(now.year, now.month, now.day);
    DateTime endOfToday = startOfToday.add(const Duration(days: 1));

    for (var expense in expenses) {
      if ((expense.dateCreated.isAfter(firstDayOfCurrentMonth) ||
              expense.dateCreated.isAtSameMomentAs(firstDayOfCurrentMonth)) &&
          (expense.dateCreated.isBefore(lastDayOfCurrentMonth) ||
              expense.dateCreated.isAtSameMomentAs(lastDayOfCurrentMonth))) {
        if (expense.type == "income") {
          netIncome += expense.amount;
          netBalance += expense.amount;
        } else {
          netSpend += expense.amount;
          netBalance -= expense.amount;
        }
      }

      if (expense.dateCreated.isAfter(startOfToday) &&
          expense.dateCreated.isBefore(endOfToday)) {
        if (expense.type != "income") {
          todaysExpense += expense.amount;
        }
      }
    }

    state = NetBalanceState(
        netBalance: netBalance,
        netIncome: netIncome,
        netSpend: netSpend,
        todaysExpense: todaysExpense);
  }
}

final netBalanceProvider =
    StateNotifierProvider<NetBalanceNotifier, NetBalanceState>(
  (ref) => NetBalanceNotifier(),
);
