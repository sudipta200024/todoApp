import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoproviderapp/theme_provider.dart';
import 'package:todoproviderapp/todo_screen.dart';
import 'package:todoproviderapp/calculator_screen.dart';
import 'package:todoproviderapp/counter_screen.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  final List<String> _titles = [
    "ToDo",
    "Calculator",
    "Counter",
  ];

  void _onItemTapped(int index) {
    setState(()=>_selectedIndex = index);
  }
  Widget _getBody(int index) {
    switch (index) {
      case 1:
        return const CalculatorScreen();
      case 2:
        return const CounterScreen();
      default:
        return const TodoScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed:(){context.read<ThemeProvider>().toggleTheme();},
          ),
        ],
      ),
      body: _getBody(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.today_outlined),
            label: "ToDo",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate_outlined),
            label: "Calculator",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later),
            label: "Counter",
          ),
        ],
      ),
    );
  }
}
