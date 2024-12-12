import 'package:flutter/material.dart';
import 'package:personal_finance/screens/dashboard_screen.dart';
import 'package:personal_finance/screens/profile_screen.dart';
import 'package:personal_finance/screens/spending_screen.dart';
import 'package:personal_finance/screens/wallet_screen.dart';
import 'package:personal_finance/widgets/nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardScreen(),
    const SpendingScreen(),
    const WalletScreen(),
    const ProfileScreen(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavBar(
        currentIndex: _currentIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}
