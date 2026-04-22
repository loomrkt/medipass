import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainNavigationPage extends StatefulWidget {
  final Widget child;

  const MainNavigationPage({super.key, required this.child});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  int _getSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/search')) return 1;
    if (location.startsWith('/ia')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0;
  }

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: ("Home"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.search),
          title: ("Rechercher"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.chat),
          title: ("IA"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: ("Profil"),
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.grey,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    _controller.index = _getSelectedIndex(context);

    return Scaffold(
      // On utilise un Stack pour placer le child de GoRouter au-dessus
      // du contenu géré par le PersistentTabView
      body: Stack(
        children: [
          PersistentTabView(
            context,
            controller: _controller,
            // On met des conteneurs vides ici pour éviter le conflit de GlobalKey
            screens: const [
              SizedBox.shrink(),
              SizedBox.shrink(),
              SizedBox.shrink(),
              SizedBox.shrink(),
            ],
            items: _navBarsItems(),
            navBarStyle: NavBarStyle.style3,
            onItemSelected: (index) {
              switch (index) {
                case 0: context.go('/home'); break;
                case 1: context.go('/search'); break;
                case 2: context.go('/ia'); break;
                case 3: context.go('/profile'); break;
              }
            },
          ),
          // Le vrai contenu (géré par GoRouter) occupe tout l'écran 
          // sauf la zone de la barre de navigation (grâce au padding ou à la position)
          SafeArea(
            bottom: false,
            child: Padding(
              // On ajuste le padding pour ne pas chevaucher la barre (environ 60px)
              padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}