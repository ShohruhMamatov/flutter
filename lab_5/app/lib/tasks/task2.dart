import 'package:flutter/material.dart';

class ColumnRowTask extends StatelessWidget {
  const ColumnRowTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Column & Row Task")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Task 4
        children: [
          const Icon(Icons.star, size: 50),
          const Icon(Icons.star, size: 50),
          const Icon(Icons.star, size: 50),
          const Icon(Icons.star, size: 50), // Added extra
          const Icon(Icons.star, size: 50), // Added extra
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Task 3
            children: const [
              Icon(Icons.favorite, size: 40, color: Colors.red),
              Icon(Icons.star, size: 40, color: Colors.yellow),
              Icon(Icons.home, size: 40, color: Colors.blue),
            ],
          ),
        ],
      ),
    );
  }
}
