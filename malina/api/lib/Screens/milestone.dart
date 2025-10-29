import 'package:api/Screens/journay.dart';
import 'package:flutter/material.dart';

class Milestone {
  final String title;
  final String date;
  final String weight;
  final String description;
  final MilestoneType type;

  Milestone({
    required this.title,
    required this.date,
    required this.weight,
    required this.description,
    required this.type,
  });
}

enum MilestoneType {
  start,
  progress,
  goal,
}

class TimelinePage extends StatelessWidget {
  const TimelinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final milestones = [
      Milestone(
        title: 'Bugun',
        date: '23 Okt 2025',
        weight: '70 kg',
        description: "Siz 19.3 kg yo'qotmoqchisiz",
        type: MilestoneType.start,
      ),
      Milestone(
        title: '3 kundan keyin',
        date: '26 Okt 2025',
        weight: '69.7 kg',
        description:
            "Birinchi natijalaringizni ko'rasiz — taxminan 300 g kamayadi. Bu odatlarni tuzatish va ovqatlanish bilan sog'lom munosabatni o'rnatishdan kelgan birinchi g'alaba",
        type: MilestoneType.progress,
      ),
      Milestone(
        title: '5 oydan keyin',
        date: '10 Apr 2026',
        weight: '50.7 kg',
        description:
            "19.3 kg yo'qotish maqsadingizga erishasiz. O'zingizni yaxshiroq, energiyaroq his qilasiz va qanchalik uzoqqa yetganingizdan faxrlanasiz.",
        type: MilestoneType.goal,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFE3F0E5),
      body: SafeArea(
        child: Column(
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Oldinda nima kutmoqda',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            // Timeline
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: milestones.length,
                itemBuilder: (context, index) {
                  final milestone = milestones[index];
                  final isLast = index == milestones.length - 1;
                  return _TimelineItem(
                    milestone: milestone,
                    isLast: isLast,
                  );
                },
              ),
            ),

            // Continue button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    print('Continue pressed');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StartJourneyPage()));
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
}

class _TimelineItem extends StatelessWidget {
  final Milestone milestone;
  final bool isLast;

  const _TimelineItem({
    required this.milestone,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              _buildTimelineIcon(),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: const Color(0xFF5FD99F),
                  ),
                ),
            ],
          ),

          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and date
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(text: milestone.title),
                        TextSpan(
                          text: ' - ${milestone.date} - ${milestone.weight}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Description
                  Text(
                    milestone.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineIcon() {
    switch (milestone.type) {
      case MilestoneType.start:
        return Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF5FD99F),
            border: Border.all(
              color: const Color(0xFF5FD99F),
              width: 3,
            ),
          ),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        );

      case MilestoneType.progress:
        return Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF5FD99F),
            border: Border.all(
              color: const Color(0xFF5FD99F),
              width: 3,
            ),
          ),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        );

      case MilestoneType.goal:
        return Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF5FD99F),
          ),
          child: const Icon(
            Icons.circle,
            color: Colors.white,
            size: 16,
          ),
        );
    }
  }
}
