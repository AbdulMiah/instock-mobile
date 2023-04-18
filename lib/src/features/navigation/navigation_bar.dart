import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:instock_mobile/src/features/account/screens/account_page.dart';
import 'package:instock_mobile/src/features/inventory/screens/add_item_page.dart';
import 'package:instock_mobile/src/features/inventory/screens/inventory_page.dart';
import 'package:instock_mobile/src/features/stats/screens/stats_page.dart';

import '../../theme/common_theme.dart';
import '../business/screens/business_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  // Implement back button with navigation bar
  // ref https://stackoverflow.com/a/62942286
  final ListQueue<int> _navigationQueue = ListQueue();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final theme = CommonTheme().themeData;
    return WillPopScope(
      // this method will be called on press of the back button
      onWillPop: () async {
        if (_navigationQueue.isEmpty) return true;

        setState(() {
          index = _navigationQueue.last;
          _navigationQueue.removeLast();
        });
        return false;
      },

      child: Scaffold(
        body: (getBody(index)),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: theme.primaryColorDark,
          selectedItemColor: theme.splashColor,
          unselectedItemColor: theme.primaryColorLight,
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          onTap: (value) {
            _navigationQueue.addLast(index);
            setState(() => index = value);
          },
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
        ),
      ),
    );
  }

  Widget? getBody(int index) {
    switch (index) {
      case 0:
        return const Inventory();
      case 1:
        return const StatsPage();
      case 2:
        return const AddItem();
      case 3:
        return const BusinessPage();
      case 4:
        return const AccountPage();
    }
    //  End of reference
  }
}
