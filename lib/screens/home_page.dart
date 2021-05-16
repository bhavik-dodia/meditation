import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/player.dart';
import '../widgets/home/home.dart';
import '../widgets/home/practices.dart';
import '../widgets/home/profile.dart';
import '../widgets/player/now_playing_mini.dart';

/// Displays home page with nevigation bar at the bottom.
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<Player>(context, listen: false).initializeSession();
    Provider.of<Player>(context, listen: false).context = context;
  }

  @override
  void dispose() {
    Provider.of<Player>(context, listen: false).closeSession();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: _currentIndex == 0
          ? AppBar(
              elevation: 0.0,
              backgroundColor: const Color(0xFF2D31AC),
              toolbarHeight: 0.0,
            )
          : _currentIndex == 1
              ? AppBar(title: const Text('Practices'))
              : AppBar(
                  elevation: 0.0,
                  toolbarHeight: 0.0,
                ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Home(),
          Practices(),
          Container(),
          Profile(),
        ],
      ),
      bottomSheet:
          Provider.of<Player>(context).isPlaying ? NowPlayingMini() : null,
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(size: 30.0),
        backgroundColor: theme.canvasColor,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        currentIndex: _currentIndex,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: 'Practices',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.self_improvement_rounded),
            label: 'Meditation',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
