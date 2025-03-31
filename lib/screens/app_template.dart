import 'package:budgetbeam/main.dart';
import 'package:budgetbeam/screens/finance_screen.dart';
import 'package:budgetbeam/screens/group_screen.dart';
import 'package:budgetbeam/screens/home_screen.dart';
import 'package:budgetbeam/screens/profile_screen.dart';
import 'package:budgetbeam/services/local_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class AppTemplate extends StatefulWidget {
  const AppTemplate({super.key});

  @override
  State<AppTemplate> createState() => _AppTemplateState();
}

class _AppTemplateState extends State<AppTemplate> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    checkAppLockStatus();
  }

  Future<void> checkAppLockStatus() async {
    final isAppLocked = await storage.read(key: 'appLockEnabled') ?? "false";
    if (isAppLocked == "true") {
      final bool didAuthenticate =
          await authenticate("Authenticate to access the app");
      if (!didAuthenticate) {
        SystemNavigator.pop();
      }
    }
  }

  List<Widget> _buildScreens() => [
        const HomeScreen(),
        const FinanceScreen(),
        const GroupScreen(),
        const ProfileScreen(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home_rounded),
          title: "Home",
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.black,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.monetization_on),
          title: "Finance",
          activeColorPrimary: Colors.teal,
          inactiveColorPrimary: Colors.black,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.group),
          title: "Groups",
          activeColorPrimary: Colors.blueAccent,
          inactiveColorPrimary: Colors.black,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person_rounded),
          title: "Profile",
          activeColorPrimary: Colors.indigo,
          inactiveColorPrimary: Colors.black,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineToSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardAppears: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        navBarStyle: NavBarStyle.style1,
      ),
    );
  }
}
