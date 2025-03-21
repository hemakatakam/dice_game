import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'screens/game_screen.dart';
import 'screens/rules_screen.dart';
import 'screens/author_screen.dart';

void main() {
  runApp(const DiceGame());
}

class DiceGame extends StatelessWidget {
  const DiceGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  
  final List<Widget> _screens = [
    const GameScreen(),
    const RulesScreen(),
    const AuthorScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _buildCupertinoScaffold() : _buildMaterialScaffold();
  }

  Widget _buildMaterialScaffold() {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.casino), label: 'Game'),
          NavigationDestination(icon: Icon(Icons.rule), label: 'Rules'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Author'),
        ],
      ),
    );
  }

  Widget _buildCupertinoScaffold() {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.game_controller), label: 'Game'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.doc_text), label: 'Rules'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: 'Author'),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) => _screens[index],
        );
      },
    );
  }
}
