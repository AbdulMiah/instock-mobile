import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/authentication/welcome_page.dart';
import 'package:instock_mobile/src/features/inventory/add_item_page.dart';
import 'package:instock_mobile/src/features/inventory/inventory_page.dart';
import 'package:instock_mobile/src/features/stats/stats_page.dart';

import '../account/account_page.dart';
import '../business/business_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    InventoryPage(),
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

  bool isUserLoggedIn() {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (!isUserLoggedIn()) {
      return const Welcome();
    }
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
        selectedItemColor: Theme.of(context).splashColor,
        backgroundColor: Theme.of(context).primaryColorDark,
        unselectedItemColor: Theme.of(context).primaryColorLight,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    ));
  }
}
