import 'package:flutter/material.dart';

class TextFieldTask extends StatefulWidget {
  const TextFieldTask({super.key});

  @override
  State<TextFieldTask> createState() => _TextFieldTaskState();
}

class _TextFieldTaskState extends State<TextFieldTask> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TextField Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _controller, // Task 4
          obscureText: true, // Task 2
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Enter your password", // Task 1
            icon: Icon(Icons.person), // Task 3
          ),
        ),
      ),
    );
  }
}
