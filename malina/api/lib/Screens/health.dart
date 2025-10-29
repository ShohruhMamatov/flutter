import 'package:api/Screens/goalweight.dart';
import 'package:flutter/material.dart';

class HealthGoalsPage extends StatefulWidget {
  const HealthGoalsPage({Key? key}) : super(key: key);

  @override
  State<HealthGoalsPage> createState() => _HealthGoalsPageState();
}

class HealthGoal {
  final String emoji;
  final String title;
  bool isSelected;

  HealthGoal({
    required this.emoji,
    required this.title,
    this.isSelected = false,
  });
}

class _HealthGoalsPageState extends State<HealthGoalsPage> {
  final List<HealthGoal> goals = [
    HealthGoal(
        emoji: '😊', title: "Menda sog'liq muammolari yo'q", isSelected: true),
    HealthGoal(emoji: '💗', title: 'Gipertoniya'),
    HealthGoal(emoji: '💧', title: 'Yuqori xolesterin'),
    HealthGoal(emoji: '💊', title: 'Diabet'),
    HealthGoal(emoji: '🖤', title: 'Yurak kasalligi'),
    HealthGoal(emoji: '🫁', title: "Nafas olish muammolari"),
    HealthGoal(emoji: '🦴', title: 'Osteoporoz'),
    HealthGoal(emoji: '🧠', title: 'Migren yoki bosh og\'rig\'i'),
    HealthGoal(emoji: '⚡', title: 'Qalqonsimon bez muammolari'),
    HealthGoal(emoji: '🔴', title: 'Anemiya'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD4E7D7),
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button and progress bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.5,
                          child: Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFF5FD99F),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Title and subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    "Sog'ligingiz bilan bog'liq muammolar bormi?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Sizning sog'ligingizni hisobga olamiz",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Scrollable options list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  final goal = goals[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: _buildOptionCard(goal, index),
                  );
                },
              ),
            ),

            // Continue button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    final selectedGoals = goals
                        .where((g) => g.isSelected)
                        .map((g) => g.title)
                        .toList();
                    print('Selected goals: $selectedGoals');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GoalWeightPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5FD99F),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Davom etish',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(HealthGoal goal, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          goal.isSelected = !goal.isSelected;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: goal.isSelected ? Colors.white : Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: goal.isSelected ? Colors.black : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Text(
              goal.emoji,
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                goal.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: goal.isSelected
                    ? const Color(0xFF5FD99F)
                    : Colors.transparent,
                border: Border.all(
                  color: goal.isSelected
                      ? const Color(0xFF5FD99F)
                      : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child: goal.isSelected
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
