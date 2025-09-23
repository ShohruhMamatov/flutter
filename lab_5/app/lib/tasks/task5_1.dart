import 'package:flutter/material.dart';

class ProfileCardTask extends StatelessWidget {
  const ProfileCardTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Card Challenge")),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      "https://picsum.photos/200", // 👈 put your image URL here
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("User Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text("@username", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text("A short bio about the user goes here..."),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: () {}, child: const Text("Follow")),
                  ElevatedButton(onPressed: () {}, child: const Text("Message")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
