import 'package:flutter/material.dart';
import 'tasks/task1.dart';
import 'tasks/task2.dart';
import 'tasks/task3.dart';
import 'tasks/task4.dart';
import 'tasks/task5_1.dart';
import 'tasks/task5_2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Lab 5: Flutter Practice",
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lab 5 Tasks")),
      body: ListView(
        children: [
          ListTile(
            title: const Text("1. Container Task"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ContainerTask()),
            ),
          ),
          ListTile(
            title: const Text("2. Column & Row Task"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ColumnRowTask()),
            ),
          ),
          ListTile(
            title: const Text("3. TextField Task"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TextFieldTask()),
            ),
          ),
          ListTile(
            title: const Text("4. Expanded / Flex Task"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ExpandedTask()),
            ),
          ),
          ListTile(
            title: const Text("5. Profile Card Challenge"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileCardTask()),
            ),
          ),
          ListTile(
            title: const Text("6. Product Item Challenge"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductItemTask()),
            ),
          ),
        ],
      ),
    );
  }
}
