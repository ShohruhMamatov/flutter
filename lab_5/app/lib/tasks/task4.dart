import 'package:flutter/material.dart';

class ExpandedTask extends StatelessWidget {
  const ExpandedTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Expanded / Flex Task")),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1, // Task 2
                child: Container(height: 100, color: Colors.red),
              ),
              Expanded(
                flex: 2, // Task 2
                child: Container(height: 100, color: Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(width: 100, height: 100, color: Colors.blue),
              const Spacer(), // Task 4
              Container(width: 100, height: 100, color: Colors.orange),
            ],
          ),
        ],
      ),
    );
  }
}
