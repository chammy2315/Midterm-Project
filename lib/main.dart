// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'login_screen.dart';
import 'task_manager_screen.dart';
import 'task_history_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

// Provider to manage the login state
final isLoggedInProvider = StateProvider<bool>((ref) => false);

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(isLoggedInProvider);

    return MaterialApp(
      home: isLoggedIn ? const HomeScreen() : const LoginScreen(),
    );
  }
}

// Main screen with BottomNavigationBar
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  // List of screens for the bottom navigation bar
  final List<Widget> _screens = [
    const Center(child: Text('Welcome to the Task Manager App')), // Home Tab
    TaskManagerScreen(), // Tasks Tab
    const TaskHistoryScreen(), // History Tab
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Responsive padding and text scale based on screen size
    final mediaQuery = MediaQuery.of(context);
    final isTabletOrLarger = mediaQuery.size.width > 600; // Example breakpoint

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
      // Add responsive padding for the bottom navigation bar
      bottomSheet: isTabletOrLarger
          ? Padding(
              padding: EdgeInsets.all(mediaQuery.size.width * 0.02),
              child: Text(
                "Tablet Mode: Enjoy the expanded view!",
                style: TextStyle(fontSize: mediaQuery.size.width * 0.015),
              ),
            )
          : null,
    );
  }
}
