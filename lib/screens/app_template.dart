import 'package:budgetbeam/screens/finance_screen.dart';
import 'package:budgetbeam/screens/group_screen.dart';
import 'package:budgetbeam/screens/home_screen.dart';
import 'package:budgetbeam/screens/profile_screen.dart';
import 'package:budgetbeam/screens/view_screen.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class AppTemplate extends StatefulWidget {
  const AppTemplate({super.key});

  @override
  State<AppTemplate> createState() => _AppTemplateState();
}

class _AppTemplateState extends State<AppTemplate> {
  late PageController _pageController;
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: _listOfWidget,
              ),
            ),
          ],
        ),
        bottomNavigationBar: SlidingClippedNavBar.colorful(
          backgroundColor: Colors.white,
          onButtonPressed: onButtonPressed,
          iconSize: 30,
          // activeColor: const Color(0xFF01579B),
          selectedIndex: selectedIndex,
          barItems: <BarItem>[
            BarItem(
              icon: Icons.home_rounded,
              title: 'Home',
              activeColor: kPrimaryColor,
              inactiveColor: Colors.black,
            ),
            BarItem(
              icon: Icons.monetization_on,
              title: 'Finance',
              activeColor: kPrimaryColor,
              inactiveColor: Colors.black,
            ),
            // BarItem(
            //   icon: Icons.insert_chart,
            //   title: 'View',
            //   activeColor: kPrimaryColor,
            //   inactiveColor: Colors.black,
            // ),
            BarItem(
              icon: Icons.group,
              title: 'Groups',
              activeColor: kPrimaryColor,
              inactiveColor: Colors.black,
            ),
            BarItem(
              icon: Icons.person_rounded,
              title: 'Profile',
              activeColor: kPrimaryColor,
              inactiveColor: Colors.black,
            ),
          ],
        ));
  }
}

List<Widget> _listOfWidget = [
  HomeScreen(),
  const FinanceScreen(),
  const GroupScreen(),
  // const ViewScreen(),
  const ProfileScreen(),
];
