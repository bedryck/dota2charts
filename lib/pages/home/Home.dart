import 'package:flutter/material.dart';
import '../profile/profile.dart';
import '../competitive/Competitive.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.search),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () => _onItemTapped(0),
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Icon(
                      Icons.dashboard,
                      color:
                          _selectedIndex == 0 ? Colors.white : Colors.grey[600],
                    )),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => _onItemTapped(1),
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Icon(
                      Icons.mouse,
                      color:
                          _selectedIndex == 1 ? Colors.white : Colors.grey[600],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
