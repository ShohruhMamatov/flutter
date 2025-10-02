import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi Route Navigation',
      routes: {
        '/': (context) => const HomePage(),
        '/top': (context) => const TopBarPage(),
        '/bottom': (context) => const BottomBarPage(),
        '/first': (context) => const FirstPage(),
      },
      initialRoute: '/',
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Initial Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/top'),
              child: const Text('Go to Top Bar Page'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/bottom'),
              child: const Text('Go to Bottom Bar Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class TopBarPage extends StatelessWidget {
  const TopBarPage({super.key});

  void goToFirst(BuildContext context) {
    Navigator.pushNamed(context, '/first');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Bar Page'),
        actions: [
          IconButton(icon: const Icon(Icons.home), onPressed: () => goToFirst(context)),
          IconButton(icon: const Icon(Icons.search), onPressed: () => goToFirst(context)),
          IconButton(icon: const Icon(Icons.notifications), onPressed: () => goToFirst(context)),
          IconButton(icon: const Icon(Icons.person), onPressed: () => goToFirst(context)),
          IconButton(icon: const Icon(Icons.settings), onPressed: () => goToFirst(context)),
        ],
      ),
      body: const Center(
        child: Text(
          'This page has a top bar with 5 navigation items.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class BottomBarPage extends StatefulWidget {
  const BottomBarPage({super.key});

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    Navigator.pushNamed(context, '/first');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bottom Bar Page')),
      body: const Center(
        child: Text(
          'This page has a bottom bar with 5 navigation items.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Likes'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Route')),
      body: const Center(
        child: Text(
          'You navigated to /first!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}


//Mamatov Shohruh 230048
//Abdurahmon Abdurazzoqov 230045
//Soibnazarov Avazbek 230047