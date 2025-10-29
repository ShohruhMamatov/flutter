import 'package:api/Screens/page4.dart';
import 'package:flutter/material.dart';

class Activeness extends StatefulWidget {
  const Activeness({super.key});

  @override
  State<Activeness> createState() => _Activeness();
}

class _Activeness extends State<Activeness> {
  // Selected activity option
  String? selectedActiveness;

  // Activity options
  final List<Map<String, String>> activityOptions = [
    {"title": "Asosan harakatsiz", "subtitle": "Stol boshida ishlayman"},
    {"title": "Kam faol", "subtitle": "Kun davomida biroz harakatlanaman"},
    {"title": "Faol", "subtitle": "Mashqlarni o'zichiga oladi"},
    {"title": "Juda faol", "subtitle": "Kunning ko'p qismida harakatlanaman"}
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
              "Faollik darajangiz qanday?",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Motivatsiyangizni tushunishimizga yordam bering",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 40),

            // Activity selection buttons
            Column(
              children: activityOptions.map((option) {
                final isSelected = selectedActiveness == option["title"];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedActiveness = option["title"];
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected
                            ? const Color.fromARGB(255, 238, 222, 158)
                            : Colors.white,
                        foregroundColor: Colors.black,
                        side: BorderSide(
                          color: isSelected
                              ? const Color.fromARGB(255, 5, 5, 5)
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
                  if (selectedActiveness == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Iltimos, maqsadni tanlang."),
                      ),
                    );
                    return;
                  }

                  debugPrint('Selected Activity: $selectedActiveness');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MalinaScreen()),
                  );
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
