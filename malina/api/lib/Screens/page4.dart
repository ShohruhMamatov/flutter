import 'package:api/Screens/gender.dart';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // 📊 For line chart

class MalinaScreen extends StatelessWidget {
  const MalinaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // --- Title ---
              const Text(
                "Malina AI uzoq muddatli natijalar beradi",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              // --- Chart Card ---
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 24,
                                interval: 1,
                                getTitlesWidget: (value, meta) => Text(
                                  value.toInt().toString(),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 35,
                                interval: 25,
                                getTitlesWidget: (value, meta) => Text(
                                  value.toInt().toString(),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            // --- Malina AI ---
                            LineChartBarData(
                              spots: const [
                                FlSpot(1, 80),
                                FlSpot(2, 75),
                                FlSpot(3, 72),
                                FlSpot(4, 70),
                                FlSpot(5, 69),
                                FlSpot(6, 68),
                              ],
                              isCurved: true,
                              color: Colors.black,
                              barWidth: 3,
                              dotData: FlDotData(show: true),
                            ),

                            // --- Traditional Diet ---
                            LineChartBarData(
                              spots: const [
                                FlSpot(1, 80),
                                FlSpot(2, 77),
                                FlSpot(3, 78),
                                FlSpot(4, 80),
                                FlSpot(5, 82),
                                FlSpot(6, 83),
                              ],
                              isCurved: true,
                              color: Colors.grey,
                              barWidth: 2,
                              isStrokeCapRound: true,
                              dashArray: [8, 4],
                              dotData: FlDotData(show: true),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // --- Legend ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.circle, size: 10, color: Colors.black),
                        SizedBox(width: 6),
                        Text("Malina AI",
                            style:
                                TextStyle(fontSize: 14, color: Colors.black)),
                        SizedBox(width: 20),
                        Icon(Icons.circle, size: 10, color: Colors.grey),
                        SizedBox(width: 6),
                        Text("An'anaviy dieta",
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                      ],
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      "Malina AI foydalanuvchilarining 80% vazn yo'qotishni 6 oydan keyin ham saqlab qoladi",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              // --- Continue Button ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 200,
                      maxWidth: 400,
                      minHeight: 55,
                      maxHeight: 55,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Gender()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber[500],
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Davom etish", style: TextStyle(fontSize: 18)),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
