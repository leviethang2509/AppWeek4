import 'package:flutter/material.dart';
import 'list_view_screen.dart';
import 'grid_view_screen.dart';
import 'shared_preferences_screen.dart';
import 'async_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Widget> screens = const [
    ListViewScreen(),
    GridViewScreen(),
    SharedPreferencesScreen(),
    AsyncScreen(),
  ];

  final List<String> titles = const [
    'Contacts',
    'Gallery',
    'Storage',
    'Async task',
  ];

  final List<String> subtitles = const [
    'Scrollable list view',
    'Two grid layouts',
    'Local shared preferences',
    'Future and loading state',
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titles[selectedIndex]),
            const SizedBox(height: 2),
            Text(
              subtitles[selectedIndex],
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: colorScheme.primaryContainer,
              foregroundColor: colorScheme.onPrimaryContainer,
              child: Text('${selectedIndex + 1}'),
            ),
          ),
        ],
      ),
      body: screens[selectedIndex],
      bottomNavigationBar: SafeArea(
        top: false,
        child: NavigationBar(
          height: 68,
          selectedIndex: selectedIndex,
          backgroundColor: Colors.white,
          indicatorColor: colorScheme.primaryContainer,
          onDestinationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.contacts_outlined),
              selectedIcon: Icon(Icons.contacts),
              label: 'List',
            ),
            NavigationDestination(
              icon: Icon(Icons.grid_view_outlined),
              selectedIcon: Icon(Icons.grid_view),
              label: 'Grid',
            ),
            NavigationDestination(
              icon: Icon(Icons.save_outlined),
              selectedIcon: Icon(Icons.save),
              label: 'Prefs',
            ),
            NavigationDestination(
              icon: Icon(Icons.timelapse_outlined),
              selectedIcon: Icon(Icons.check_circle),
              label: 'Async',
            ),
          ],
        ),
      ),
    );
  }
}
