import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/account/account_page.dart';
import 'package:instock_mobile/src/features/business/business_page.dart';
import 'package:instock_mobile/src/features/inventory/screens/add_item_page.dart';
import 'package:instock_mobile/src/features/stats/stats_page.dart';

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
