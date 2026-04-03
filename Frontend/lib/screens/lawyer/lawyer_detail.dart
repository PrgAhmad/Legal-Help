import 'package:flutter/material.dart';
import 'package:frontend/screens/lawyer/widgets/address.dart';
import 'package:frontend/screens/lawyer/widgets/consult_and_book.dart';
import 'package:frontend/screens/lawyer/widgets/lawyer_header.dart';
import 'package:frontend/screens/lawyer/widgets/my_info_card.dart';
import 'package:frontend/screens/lawyer/widgets/my_intro.dart';
import 'package:frontend/screens/lawyer/widgets/practice_area.dart';
import 'package:frontend/widgets/my_app_bar.dart';


class LawyerDetail extends StatelessWidget {
  final Map lawyer;
  const LawyerDetail({super.key, required this.lawyer});

  @override
  Widget build(BuildContext context) {
    Map professional = lawyer['professional'];
    Map introduction = lawyer["introduction"];
    final otherAreas = (professional["expertise"] as List<dynamic>?) ?? [];

    return Scaffold(
      appBar: MyAppBar(context, title: lawyer['fullName']),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LawyerHeader(context, lawyer: lawyer),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: MyInfoCard(
                    context,
                    icon: Icons.balance,
                    label: 'Experience',
                    value: '${professional['experience'] ?? '2'} years',
                  ),
                ),
                Expanded(
                  child: MyInfoCard(
                    context,
                    icon: Icons.verified_user_rounded,
                    label: 'Bar Number',
                    value: professional['barCouncilId'] ?? 'B/345/24543',
                    isSmall: true,
                  ),
                ),
              ],
            ),
            Address(context, lawyer: lawyer),

            PracticeArea(context, otherAreas: otherAreas),

            MyIntro(
              shortIntro: introduction["shortIntro"],
              detailedIntro: introduction["detailedIntro"],
            ),
            // Action Buttons
            SizedBox(height: 8),
          ],
        ),
      ),
      bottomNavigationBar: ConsultAndBook(),
    );
  }
}
