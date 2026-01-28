import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import 'package:frontend/features/home/presentation/screens/home_screen.dart';
import 'package:frontend/features/profile/presentation/screens/profile_screen.dart';
import 'package:frontend/config/themes/app_colors.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PersistentTabController _controller =
        PersistentTabController(initialIndex: 0);

    return WillPopScope(
      onWillPop: () async {
        if (_controller.index != 0) {
          _controller.jumpToTab(0);
          return false;
        }
        return true;
      },
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: const [
          HomeShell(),
          Center(child: Text('Search', style: TextStyle(fontSize: 24))),
          Center(child: Text('Add', style: TextStyle(fontSize: 24))),
          Center(child: Text('Chat', style: TextStyle(fontSize: 24))),
          ProfileScreen(),
        ],
        items: _navBarItems(),
        confineToSafeArea: true,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        backgroundColor: Colors.transparent,
        navBarHeight: 75,
        margin: const EdgeInsets.all(16),
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(25),
          colorBehindNavBar: Colors.transparent,
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        navBarStyle: NavBarStyle.style6,
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home, size: 26),
        title: "Home",
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.textSecondary,
        contentPadding: 2,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search, size: 26),
        title: "Search",
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.textSecondary,
        contentPadding: 2,
      ),
      PersistentBottomNavBarItem(
        icon: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              // ignore: deprecated_member_use
              colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: const Icon(Icons.add, size: 32, color: Colors.white),
        ),
        title: "",
        activeColorPrimary: Colors.transparent,
        inactiveColorPrimary: Colors.transparent,
        contentPadding: 0,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.chat_bubble, size: 26),
        title: "Chat",
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.textSecondary,
        contentPadding: 2,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person, size: 26),
        title: "Profile",
        activeColorPrimary: AppColors.primary,
        inactiveColorPrimary: AppColors.textSecondary,
        contentPadding: 2,
      ),
    ];
  }
}
