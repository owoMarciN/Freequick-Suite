import 'package:flutter/material.dart';
import 'package:user_app/screens/users/favorites_screen.dart';
import 'package:user_app/screens/users/home_screen.dart';
import 'package:user_app/screens/orders/orders_screen.dart';
import 'package:user_app/screens/users/search_screen.dart';
import 'package:shared_assets/extensions/extensions.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const OrdersScreen(),
    const SearchScreen(initialText: ''),
    const FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: context.l10nCustomer.navHome),
          BottomNavigationBarItem(
              icon: const Icon(Icons.reorder),
              label: context.l10nCustomer.navOrders),
          BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: context.l10nCustomer.navSearch),
          BottomNavigationBarItem(
              icon: const Icon(Icons.favorite),
              label: context.l10nCustomer.navFavorites),
        ],
      ),
    );
  }
}