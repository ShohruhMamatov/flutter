import 'package:flutter/material.dart';

class ContainerTask extends StatelessWidget {
  const ContainerTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Container Task")),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20.0), // Practice Task 4
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.redAccent, // Practice Task 1
            borderRadius: BorderRadius.circular(12), // Practice Task 3
          ),
          height: 150, // Practice Task 1
          width: 150,
          child: const Icon(Icons.home, size: 40), // Practice Task 2
        ),
      ),
    );
  }
}
