import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'task_manager_screen.dart';
import 'task_history_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  // Define the screens for each tab
  final List<Widget> _screens = [
    const Center(child: Text('Welcome to the Task Manager App')), // Home
    TaskManagerScreen(), // Tasks
    const TaskHistoryScreen(), // History
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0 ? 'Home' : _selectedIndex == 1 ? 'Tasks' : 'History',
          style: TextStyle(fontSize: screenWidth * 0.06), // Adjusting font size for title
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Center(
          child: _screens[_selectedIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: screenWidth * 0.08), // Adjust icon size
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task, size: screenWidth * 0.08), // Adjust icon size
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history, size: screenWidth * 0.08), // Adjust icon size
            label: 'History',
          ),
        ],
      ),
    );
  }
}
