import 'package:flutter/material.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  // Selected activity option
  String? selectedActivity;

  // Activity options
  final List<Map<String, String>> activityOptions = [
    {"title": "0-2", "subtitle": "Vaqti-vaqti bilan mashqlar"},
    {"title": "3-5", "subtitle": "Haftasiga bir necha marta"},
    {"title": "6+", "subtitle": "Sodiq Sportchi"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Haftasiga necha marta mashq qilasiz?",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Bu sizning maxsus rejangizni sozlash uchun ishlatiladi.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 40),

            // Activity selection buttons
            Column(
              children: activityOptions.map((option) {
                final isSelected = selectedActivity == option["title"];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedActivity = option["title"];
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isSelected ? const Color(0xFFFBD43B) : Colors.white,
                        foregroundColor: Colors.black,
                        side: BorderSide(
                          color: isSelected
                              ? const Color(0xFFFBD43B)
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: isSelected ? 3 : 0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            option["title"]!,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            option["subtitle"]!,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const Spacer(),

            // Continue button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedActivity == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Iltimos, mashq chastotasini tanlang."),
                      ),
                    );
                    return;
                  }

                  debugPrint('Selected Activity: $selectedActivity');
                  // TODO: Navigate to next page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFBD43B),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Davom etish",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
