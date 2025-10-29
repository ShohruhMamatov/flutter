import 'package:api/Screens/date.dart';
import 'package:api/Screens/numexercises.dart';
import 'package:flutter/material.dart';

class HeightWeightScreen extends StatefulWidget {
  const HeightWeightScreen({super.key});

  @override
  State<HeightWeightScreen> createState() => _HeightWeightScreenState();
}

class _HeightWeightScreenState extends State<HeightWeightScreen> {
  // Default selections
  String? selectedHeight;
  String? selectedWeight;

  // Generate ranges
  final List<String> heightValues =
      List.generate(81, (index) => "${140 + index} cm"); // 140–220
  final List<String> weightValues =
      List.generate(111, (index) => "${40 + index} kg"); // 40–150

  @override
  void initState() {
    super.initState();
    selectedHeight = "170 cm"; // default value
    selectedWeight = "70 kg"; // default value
  }

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
              "Bo'y va vazn",
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

            // Dropdowns Row
            Row(
              children: [
                // Height
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Bo'y",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: selectedHeight,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        items: heightValues
                            .map((val) => DropdownMenuItem(
                                  value: val,
                                  child: Text(val),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() => selectedHeight = value);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),

                // Weight
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Vazn",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: selectedWeight,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        items: weightValues
                            .map((val) => DropdownMenuItem(
                                  value: val,
                                  child: Text(val),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() => selectedWeight = value);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  // Example: print selected values
                  debugPrint(
                      'Height: $selectedHeight, Weight: $selectedWeight');

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DateOfBirthPage(),
                    ),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
