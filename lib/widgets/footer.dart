import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  Footer({required this.currentIndex, required this.onTabTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: 'Deposit',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.money_off),
          label: 'Withdraw',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.send),
          label: 'Send Money',
        ),
      ],
    );
  }
}
