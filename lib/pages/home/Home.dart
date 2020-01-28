import 'package:flutter/material.dart';
import '../profile/profile.dart';
import '../competitive/Competitive.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;

  static List<Widget> _widgetOptions = <Widget>[
    Profile(),
    Competitive(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark;

    final ThemeData theme = Theme.of(context);
    isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            title: Text('Dashboard'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mouse),
            title: Text('Pro Dota'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: isDark ? Colors.white : null,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
