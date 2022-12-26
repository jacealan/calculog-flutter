import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> menus = [
    "m1",
    "m2",
    "m3",
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Parser p = Parser();
    Expression exp = p.parse('10^3+5*2');
    print(exp.evaluate(EvaluationType.REAL, ContextModel()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculog"),
      ),
      body: Column(
        children: const [
          Flexible(
            flex: 1,
            child: Text("1"),
          ),
          Flexible(
            flex: 1,
            child: Text("1"),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.menu),
            label: menus[0],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.menu),
            label: menus[1],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.menu),
            label: menus[2],
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightGreen,
        onTap: _onItemTapped,
      ),
    );
  }
}
