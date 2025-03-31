import 'package:budgetbeam/screens/add_expense.dart';
import 'package:budgetbeam/screens/add_friend.dart';
import 'package:budgetbeam/screens/add_group.dart';
import 'package:budgetbeam/screens/app_template.dart';
import 'package:budgetbeam/screens/finance_details_screen.dart';
import 'package:budgetbeam/screens/finance_screen.dart';
import 'package:budgetbeam/screens/friend_requests.dart';
import 'package:budgetbeam/screens/login_screen.dart';
import 'package:budgetbeam/screens/onboarding.dart';
import 'package:budgetbeam/screens/profile_screen.dart';
import 'package:budgetbeam/screens/view_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const AppTemplate(),
  '/onboarding': (context) => const Onboarding(),
  '/login': (context) => const LoginScreen(),
  '/view': (context) => const ViewScreen(),
  '/finance': (context) => const FinanceScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/finance-details': (context) => const FinanceDetailsScreen(),
  '/add-expense': (context) => const AddExpense(),
  '/add-group': (context) => const AddGroup(),
  '/add-friend': (context) => const AddFriend(),
  '/friend-requests': (context) => const FriendRequestScreen(),
};

void navigateTo(BuildContext context, String route, Object? arguments) {
  PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
    context,
    screen: appRoutes[route]!(context),
    withNavBar: false,
    settings: RouteSettings(name: route),
    pageTransitionAnimation: PageTransitionAnimation.cupertino,
  );
}
