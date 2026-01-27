import 'package:flutter/material.dart';
import 'package:frontend/screens/lawyer/widgets/address.dart';
import 'package:frontend/screens/lawyer/widgets/consult_and_book.dart';
import 'package:frontend/screens/lawyer/widgets/lawyer_header.dart';
import 'package:frontend/screens/lawyer/widgets/my_info_card.dart';
import 'package:frontend/screens/lawyer/widgets/my_intro.dart';
import 'package:frontend/screens/lawyer/widgets/practice_area.dart';
import 'package:frontend/widgets/my_app_bar.dart';
import 'package:frontend/widgets/my_container.dart';
import 'package:frontend/widgets/my_text.dart';

class LawyerDetail extends StatelessWidget {
  final Map lawyer;
  const LawyerDetail({super.key, required this.lawyer});

  @override
  Widget build(BuildContext context) {
    final otherAreas = (lawyer['otherPracticeAreas'] as List<dynamic>?) ?? [];

    return Scaffold(
      appBar: MyAppBar(context, title: lawyer['name']),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LawyerHeader(context, lawyer: lawyer),
            // if (lawyer['rating'] != null)
            // MyContainer(
            //   width: MediaQuery.of(context).size.width,
            //   padding: EdgeInsets.all(14),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     spacing: 8,
            //     children: [
            //       MyText(
            //         'Rating',
            //         fontWeight: FontWeight.w700,
            //         fontSize: 13,
            //         textAlign: TextAlign.left,
            //       ),
            //       Row(
            //         spacing: 8,
            //         children: [
            //           Icon(Icons.star_rounded, size: 24, color: Colors.amber),
            //           MyText(
            //             '${lawyer['rating'] ?? 4.5}',
            //             fontSize: 18,
            //             fontWeight: FontWeight.w700,
            //             textAlign: TextAlign.left,
            //           ),
            //           MyText(
            //             '/ 5.0',
            //             fontSize: 12,
            //             fontWeight: FontWeight.w500,
            //             color: Colors.grey[600],
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: MyInfoCard(
                    context,
                    icon: Icons.balance,
                    label: 'Experience',
                    value: '${lawyer['experience'] ?? '2'} years',
                  ),
                ),
                Expanded(
                  child: MyInfoCard(
                    context,
                    icon: Icons.verified_user_rounded,
                    label: 'Bar Number',
                    value: lawyer['barRegistration'] ?? 'B/345/24543',
                    isSmall: true,
                  ),
                ),
              ],
            ),
            Address(context, lawyer: lawyer),

            PracticeArea(context, otherAreas: otherAreas),

            MyIntro(
              shortIntro: lawyer["shortIntro"],
              detailedIntro: lawyer["detailedIntro"],
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
