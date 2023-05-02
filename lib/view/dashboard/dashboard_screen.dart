import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:social_hub/res/color.dart';
import 'package:social_hub/view/profile/profile_screen.dart';
import 'package:social_hub/view/user/user_list_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final controller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreen() {
    return [
      const Text('Home'),
      const Text('Home'),
      const Text('Home'),
      const UserListScreen(),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _nevBarItem() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          inactiveIcon: const Icon(
            Icons.home,
            color: AppColors.lightGrayColor,
          ),
          activeColorPrimary: Colors.blue),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.message),
          inactiveIcon: const Icon(
            Icons.message,
            color: AppColors.lightGrayColor,
          ),
          activeColorPrimary: Colors.blue),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.add),
          inactiveIcon: const Icon(
            Icons.add,
            color: AppColors.lightGrayColor,
          ),
          activeColorPrimary: Colors.blue),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.notification_add),
          inactiveIcon: const Icon(
            Icons.notification_add,
            color: AppColors.lightGrayColor,
          ),
          activeColorPrimary: Colors.blue),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          inactiveIcon: const Icon(
            Icons.person,
            color: AppColors.lightGrayColor,
          ),
          activeColorPrimary: Colors.blue),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreen(),
      items: _nevBarItem(),
      controller: controller,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(100),
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }
}
