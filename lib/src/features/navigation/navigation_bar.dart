import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instock_mobile/src/features/account/account_page.dart';
import 'package:instock_mobile/src/features/inventory/screens/add_item_page.dart';
import 'package:instock_mobile/src/features/stats/stats_page.dart';

import '../../theme/common_theme.dart';
import '../business/screens/business_page.dart';
import '../inventory/screens/inventory_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Inventory(),
    StatsPage(),
    AddItemPage(),
    BusinessPage(),
    AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme().themeData;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light
                .copyWith(statusBarColor: Colors.transparent),
            child: Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.signal_cellular_alt),
                label: 'Stats',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_box),
                label: 'Add Item',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.storefront),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined),
                label: 'Account',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: theme.splashColor,
            backgroundColor: theme.primaryColorDark,
            unselectedItemColor: theme.primaryColorLight,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
          ),
        ));
  }
}
