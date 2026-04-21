import 'package:flutter/material.dart';
import 'package:medipass/features/home/presentation/pages/home_page.dart';
import 'package:medipass/features/profile/presentation/pages/profil_page.dart';
import 'package:medipass/features/search/presentation/pages/search_page.dart';
import 'package:medipass/features/ia/presentation/pages/ia_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() => [
        HomePage(),
        SearchPage(),
        IAPage(),
        ProfilePage()
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          title: ('Home'),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.search),
          title: ('Rechercher'),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.chat),
          title: ('IA'),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.person),
          title: ('Profil'),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarStyle: NavBarStyle.style3,
    );
  }
}