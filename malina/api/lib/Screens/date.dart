import 'package:api/Screens/health.dart';
import 'package:flutter/material.dart';

class DateOfBirthPage extends StatefulWidget {
  const DateOfBirthPage({Key? key}) : super(key: key);

  @override
  State<DateOfBirthPage> createState() => _DateOfBirthPageState();
}

class _DateOfBirthPageState extends State<DateOfBirthPage> {
  String selectedMonth = 'Fevral';
  int selectedDay = 3;
  String selectedYear = 'Year';

  final List<String> months = [
    'Yanvar',
    'Fevral',
    'Mart',
    'Aprel',
    'May',
    'Iyun',
    'Iyul',
    'Avgust',
    'Sentabr',
    'Oktabr',
    'Noyabr',
    'Dekabr'
  ];

  final List<int> days = List.generate(31, (index) => index + 1);

  List<String> get years {
    final currentYear = DateTime.now().year;
    return List.generate(100, (index) => (currentYear - index).toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD4E7D7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {},
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
              ),

              const SizedBox(height: 40),

              // Title
              const Text(
                "Qachon tug'ildingiz?",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 16),

              // Subtitle
              const Text(
                'Bu sizning maxsus rejangizni sozlash uchun ishlatiladi.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 40),

              // Date selection dropdowns
              Row(
                children: [
                  // Month dropdown
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Oy',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildDropdown(
                          value: selectedMonth,
                          items: months,
                          onChanged: (value) {
                            setState(() {
                              selectedMonth = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Day dropdown
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Kun',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildDropdown(
                          value: selectedDay.toString(),
                          items: days.map((d) => d.toString()).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDay = int.parse(value!);
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Year dropdown
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Yil',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildDropdown(
                          value: selectedYear,
                          items: ['Year', ...years],
                          onChanged: (value) {
                            setState(() {
                              selectedYear = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Continue button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle continue action
                    print(
                        'Selected date: $selectedMonth $selectedDay, $selectedYear');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HealthGoalsPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7DD3AE),
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

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          dropdownColor: const Color(0xFFE8F5E9),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
