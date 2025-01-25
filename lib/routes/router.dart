import 'package:budgetbeam/screens/add_expense.dart';
import 'package:budgetbeam/screens/app_template.dart';
import 'package:budgetbeam/screens/finance_details_screen.dart';
import 'package:budgetbeam/screens/finance_screen.dart';
import 'package:budgetbeam/screens/login_screen.dart';
import 'package:budgetbeam/screens/onboarding.dart';
import 'package:budgetbeam/screens/profile_screen.dart';
import 'package:budgetbeam/screens/view_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const AppTemplate(),
  '/onboarding': (context) => const Onboarding(),
  '/login': (context) => const LoginScreen(),
  '/view': (context) => const ViewScreen(),
  '/finance': (context) => const FinanceScreen(),
  '/profile': (context) => ProfileScreen(),
  '/finance-details': (context) => const FinanceDetailsScreen(),
  '/add-expense': (context) => const AddExpense(),
};

void navigateTo(BuildContext context, String route, Object? arguments) {
  Navigator.pushNamed(context, route, arguments: arguments);
}
